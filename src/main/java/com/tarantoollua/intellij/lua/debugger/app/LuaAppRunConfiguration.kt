/*
 * Copyright (c) 2017. tarantoolluazx(love.tarantoolluazx@qq.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.tarantoollua.intellij.lua.debugger.app

import com.intellij.execution.ExecutionException
import com.intellij.execution.Executor
import com.intellij.execution.configurations.*
import com.intellij.execution.runners.ExecutionEnvironment
import com.intellij.openapi.module.Module
import com.intellij.openapi.module.ModuleManager
import com.intellij.openapi.options.SettingsEditor
import com.intellij.openapi.options.SettingsEditorGroup
import com.intellij.openapi.project.Project
import com.intellij.openapi.roots.ModuleRootManager
import com.intellij.openapi.util.InvalidDataException
import com.intellij.openapi.util.JDOMExternalizerUtil
import com.intellij.openapi.util.SystemInfoRt
import com.intellij.openapi.util.WriteExternalException
import com.intellij.openapi.vfs.VirtualFile
import com.intellij.util.execution.ParametersListUtil
import com.sun.jna.platform.win32.WinDef.BOOL
import com.tarantoollua.intellij.lua.debugger.DebuggerType
import com.tarantoollua.intellij.lua.debugger.IRemoteConfiguration
import com.tarantoollua.intellij.lua.debugger.LuaCommandLineState
import com.tarantoollua.intellij.lua.debugger.LuaRunConfiguration
import com.tarantoollua.intellij.lua.project.LuaSettings
import com.tarantoollua.intellij.lua.psi.LuaFileUtil
import org.jdom.Element
import java.io.File
import java.nio.charset.Charset
import java.util.*
import kotlin.collections.ArrayList

/**
 *
 * Created by tarantoolluazx on 2017/5/7.
 */
class LuaAppRunConfiguration(project: Project, factory: ConfigurationFactory)
    : LuaRunConfiguration(project, factory), IRemoteConfiguration {

//    var program = PathEnvironmentVariableUtil.findInPath("")?.absolutePath
//            ?: if (SystemInfoRt.isWindows) "tarantool.exe" else "tarantool"
    var program: String = ""
        get() {
            if (field == "" || field == "/" || field =="null")
                field = LuaSettings.Companion.instance.tarantoolExe.toString()
            return field
        }
    var file: String? = null
        set(value)
        {
            if (value != null) {
                val lastSlashIndex = value.lastIndexOf('/')
                if (lastSlashIndex != -1)
                    workingDir = value.subSequence(0, lastSlashIndex).toString()
            }
            field = value
        }
    var parameters: String? = null
    var charset: String = "UTF-8"
    var showConsole = true
    private var remappingSrcs: String = ""

    var debuggerType: DebuggerType = DebuggerType.Attach
        get() {
            if (!SystemInfoRt.isWindows && field == DebuggerType.Attach)
                field = DebuggerType.Mob
            return field
        }

    override fun getValidModules(): Collection<Module> {
        return emptyList()
    }

    override fun getConfigurationEditor(): SettingsEditor<out RunConfiguration> {
        val group = SettingsEditorGroup<LuaAppRunConfiguration>()
        group.addEditor("program", LuaAppSettingsEditor(project))
        return group
    }

    @Throws(ExecutionException::class)
    override fun getState(executor: Executor, executionEnvironment: ExecutionEnvironment): RunProfileState? {
        return LuaCommandLineState(executionEnvironment)
    }

    @Throws(WriteExternalException::class)
    override fun writeExternal(element: Element) {
        super.writeExternal(element)
        // writeField
        JDOMExternalizerUtil.writeField(element, "program", program)
        JDOMExternalizerUtil.writeField(element, "file", file)
        JDOMExternalizerUtil.writeField(element, "workingDir", workingDir)
        // JDOMExternalizerUtil.writeField(element, "tarantoolSrc", tarantoolSrc)
        JDOMExternalizerUtil.writeField(element, "debuggerType", debuggerType.value().toString())
        JDOMExternalizerUtil.writeField(element, "params", parameters)
        JDOMExternalizerUtil.writeField(element, "charset", charset)
        JDOMExternalizerUtil.writeField(element, "showConsole", if (showConsole) "true" else "false")
        JDOMExternalizerUtil.writeField(element, "remappingSrcs", remappingSrcs)
    }

    @Throws(InvalidDataException::class)
    override fun readExternal(element: Element) {
        super.readExternal(element)
        JDOMExternalizerUtil.readField(element, "program")?.let { program = it }
        file = JDOMExternalizerUtil.readField(element, "file")
        workingDir = JDOMExternalizerUtil.readField(element, "workingDir")
        // tarantoolSrc = JDOMExternalizerUtil.readField(element, "tarantoolSrc")

        JDOMExternalizerUtil.readField(element, "debuggerType")
                ?.let { debuggerType = DebuggerType.valueOf(Integer.parseInt(it)) }

        parameters = JDOMExternalizerUtil.readField(element, "params")
        charset = JDOMExternalizerUtil.readField(element, "charset") ?: "UTF-8"
        showConsole = JDOMExternalizerUtil.readField(element, "showConsole") == "true"
        JDOMExternalizerUtil.readField(element, "remappingSrcs")?.let {remappingSrcs = it}
    }

    override val port = 8172

    val virtualFile: VirtualFile?
        get() = LuaFileUtil.findFile(project, file)

    val parametersArray: Array<String>
        get() {
            val list = ArrayList<String>()
            if (false == parameters?.isEmpty()) {
                val strings = ParametersListUtil.parseToArray(parameters!!)
                list.addAll(Arrays.asList(*strings))
            }
            val file = file
            if (file != null && file.isNotEmpty()) {
                list.add(file)
            }
            return list.toTypedArray()
        }

//    var tarantoolSrc: String? = null
//        get() {
//            val ts = field
//            if (ts == null || ts.isEmpty()) {
//                field = defaultTarantoolSrc
//                return defaultTarantoolSrc
//            }
//            return ts
//        }

    fun getSourcesForRemapping(): ArrayList<Pair<String, String>> {
        // val tempArr: ArrayList<String> = ArrayList(remappingSrcs!!.subSequence(1, remappingSrcs!!.length - 1).split("), (")
        if (remappingSrcs == "[]")
            return ArrayList<Pair<String, String>>()
        val tempArr: ArrayList<String> = ArrayList(remappingSrcs!!.split("), ("))
        var tempSrcs = ArrayList<Pair<String, String>>()
        var tempPairArr: ArrayList<String>
        var tempPair: Pair<String, String>
        for (i in 0 until  tempArr.size)
        {
            if (tempArr[i][0] == '[') {
                tempArr[i] = tempArr[i].subSequence(1, tempArr[i].length).toString()
            }
            if (tempArr[i][0] == '(') {
                tempArr[i] = tempArr[i].subSequence(1, tempArr[i].length).toString()
            }
            if (tempArr[i][tempArr[i].length - 1] == ']') {
                tempArr[i] = tempArr[i].subSequence(0, tempArr[i].length - 1).toString()
            }
            if (tempArr[i][tempArr[i].length - 1] == ')') {
                tempArr[i] = tempArr[i].subSequence(0, tempArr[i].length - 1).toString()
            }
            tempPairArr = ArrayList(tempArr[i].split(", "))
            tempPair = Pair(tempPairArr[0], tempPairArr[1])
            tempSrcs.add(tempPair)
        }
        // val tempSrcs = remappingSrcs.to(ArrayList<Pair<String, String>>())
        return tempSrcs
    }
    fun setSourcesForRemapping(tempSrcs: ArrayList<Pair<String, String>>) {
        remappingSrcs = tempSrcs.toString()
    }
//    var remappingSrcs: String? = null
//        get() {
//            val rs = field
//            if (rs == null || rs.isEmpty()) {
//                field = defaultRemappingSrcs
//                return defaultRemappingSrcs
//            }
//            return rs
//        }
//
//    private val defaultRemappingSrcs: String?
//        get() {
//            return "null"
//        }


    var workingDir: String? = null
        get() {
            val wd = field
            if (wd == null || wd.isEmpty() || wd == "/") {
                field = defaultWorkingDir
                return defaultWorkingDir
            }
            return wd
        }
//    private val defaultTarantoolSrc: String?
//        get() {
//            return "path/to/tarantool/src"
//        }

    private val defaultWorkingDir: String?
        get() {
            if (file != null) {
                val lastSlashIndex = file!!.lastIndexOf('/')
                if (lastSlashIndex != -1)
                    return file?.subSequence(0, lastSlashIndex).toString()
            }
//            var projectPath = ModuleManager.getInstance(project).modules[0].project.basePath
//            if (projectPath != null)
//                return projectPath
            val modules = ModuleManager.getInstance(project).modules
            for (module in modules) {
                val sourceRoots = ModuleRootManager.getInstance(module).sourceRoots
                for (sourceRoot in sourceRoots) {
                    val path = sourceRoot.canonicalPath
                    if (path != null) {
                        return path
                    }
                }
            }
            return null
        }

    override fun checkConfiguration() {
        super.checkConfiguration()
        if (debuggerType == DebuggerType.Attach) {
            throw RuntimeConfigurationError("Unfortunately, attach debugger is no longer available. Please try remote debugger.")
        }

        val program = program
//        if (program.isEmpty()) {
        if (program == null || !File(program).exists()) {
            throw RuntimeConfigurationError("Program doesn't exist.")
        }

        val workingDir = workingDir
        if (workingDir == null || !File(workingDir).exists()) {
            throw RuntimeConfigurationError("Working dir doesn't exist.")
        }

//        val tarantoolSrc = tarantoolSrc
//        if (tarantoolSrc == null || !File(workingDir).exists()) {
//            throw RuntimeConfigurationError("Tarantool Source doesn't exist.")
//        }
        val remappingSrcs = remappingSrcs
        if (remappingSrcs == null || !File(workingDir).exists()) {
            throw RuntimeConfigurationError("Remapping Sources doesn't exist.")
        }
    }

    override fun createCommandLine() = GeneralCommandLine().withExePath(program)
            .withEnvironment(envs)
            .withParameters(*parametersArray)
            .withWorkDirectory(workingDir)
            .withCharset(Charset.forName(charset))
}
