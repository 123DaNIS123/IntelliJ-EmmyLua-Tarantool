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

package com.tarantoollua.intellij.lua.stubs

import com.intellij.lang.ASTNode
import com.intellij.openapi.diagnostic.Logger
import com.intellij.psi.PsiFile
import com.intellij.psi.StubBuilder
import com.intellij.psi.stubs.*
import com.intellij.psi.tree.IStubFileElementType
import com.intellij.util.io.StringRef
import com.tarantoollua.intellij.lua.lang.LuaLanguage
import com.tarantoollua.intellij.lua.lang.LuaParserDefinition
import com.tarantoollua.intellij.lua.psi.LuaPsiFile

/**

 * Created by tarantoolluazx on 2016/11/27.
 */
class LuaFileElementType : IStubFileElementType<LuaFileStub>(LuaLanguage.INSTANCE) {

    companion object {
        val LOG = Logger.getInstance(LuaFileElementType::class.java)
    }

    // debug performance
    override fun parseContents(chameleon: ASTNode): ASTNode? {
        val psi = chameleon.psi
        val t = System.currentTimeMillis()
        val contents = super.parseContents(chameleon)
        if (psi is LuaPsiFile) {
            if (LOG.isDebugEnabled) {
                val dt = System.currentTimeMillis() - t
                val fileName = psi.name
                println("$fileName : $dt")
                LOG.debug("$fileName : $dt")
            }
        }
        return contents
    }

    override fun getBuilder(): StubBuilder {
        return object : DefaultStubBuilder() {

            private var isTooLarger = false

            override fun createStubForFile(file: PsiFile): StubElement<*> {
                if (file is LuaPsiFile){
                    isTooLarger = file.tooLarger
                    return LuaFileStub(file)
                }
                return super.createStubForFile(file)
            }

            override fun skipChildProcessingWhenBuildingStubs(parent: ASTNode, node: ASTNode): Boolean {
                return isTooLarger
            }
        }
    }

    override fun serialize(stub: LuaFileStub, dataStream: StubOutputStream) {
        dataStream.writeName(stub.module)
        dataStream.writeUTFFast(stub.uid)
        if (LOG.isTraceEnabled) {
            println("--------- START: ${stub.psi.name}")
            println(stub.printTree())
            println("--------- END: ${stub.psi.name}")
        }
    }

    override fun deserialize(dataStream: StubInputStream, parentStub: StubElement<*>?): LuaFileStub {
        val moduleRef = dataStream.readName()
        val uid = dataStream.readUTFFast()
        return LuaFileStub(null, StringRef.toString(moduleRef), uid)
    }

    override fun getExternalId() = "lua.file"
}

class LuaFileStub : PsiFileStubImpl<LuaPsiFile> {
    private var file: LuaPsiFile? = null
    private var moduleName:String? = null

    val uid: String

    constructor(file: LuaPsiFile) : this(file, file.moduleName, file.uid)

    constructor(file: LuaPsiFile?, module:String?, uid: String) : super(file) {
        this.file = file
        this.uid = uid
        moduleName = module
    }

    val module: String? get() {
        return moduleName
    }

    override fun getType(): LuaFileElementType = LuaParserDefinition.FILE
}