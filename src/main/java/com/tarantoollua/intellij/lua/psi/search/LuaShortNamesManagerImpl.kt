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

package com.tarantoollua.intellij.lua.psi.search

import com.intellij.openapi.project.Project
import com.intellij.util.Processor
import com.tarantoollua.intellij.lua.psi.LuaClass
import com.tarantoollua.intellij.lua.psi.LuaClassMember
import com.tarantoollua.intellij.lua.psi.LuaTypeAlias
import com.tarantoollua.intellij.lua.search.SearchContext
import com.tarantoollua.intellij.lua.stubs.index.LuaAliasIndex
import com.tarantoollua.intellij.lua.stubs.index.LuaClassIndex
import com.tarantoollua.intellij.lua.stubs.index.LuaClassMemberIndex
import com.tarantoollua.intellij.lua.ty.ITyClass

class LuaShortNamesManagerImpl : LuaShortNamesManager() {

    override fun findClass(name: String, context: SearchContext): LuaClass? {
        return LuaClassIndex.find(name, context)
    }

    override fun findMember(type: ITyClass, fieldName: String, context: SearchContext): LuaClassMember? {
        return LuaClassMemberIndex.find(type, fieldName, context)
    }

    override fun processAllClassNames(project: Project, processor: Processor<String>): Boolean {
        return LuaClassIndex.processKeys(project, processor)
    }

    override fun processClassesWithName(name: String, context: SearchContext, processor: Processor<LuaClass>): Boolean {
        return LuaClassIndex.process(name, context.project, context.scope, Processor { processor.process(it) })
    }

    override fun getClassMembers(clazzName: String, context: SearchContext): Collection<LuaClassMember> {
        return LuaClassMemberIndex.instance.get(clazzName.hashCode(), context.project, context.scope)
    }

    override fun processAllMembers(type: ITyClass, fieldName: String, context: SearchContext, processor: Processor<LuaClassMember>): Boolean {
        return LuaClassMemberIndex.processAll(type, fieldName, context, processor)
    }

    override fun findAlias(name: String, context: SearchContext): LuaTypeAlias? {
        return LuaAliasIndex.find(name, context)
    }

    override fun processAllAlias(project: Project, processor: Processor<String>): Boolean {
        return LuaAliasIndex.instance.processAllKeys(project, processor)
    }
}