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

package com.tarantoollua.intellij.lua.stubs.index

import com.intellij.psi.stubs.StringStubIndexExtension
import com.intellij.psi.stubs.StubIndexKey
import com.tarantoollua.intellij.lua.comment.psi.LuaDocTagAlias
import com.tarantoollua.intellij.lua.search.SearchContext

class LuaAliasIndex : StringStubIndexExtension<LuaDocTagAlias>() {
    companion object {
        val instance = LuaAliasIndex()

        fun find(name: String, context: SearchContext): LuaDocTagAlias? {
            if (context.isDumb)
                return null
            return instance.get(name, context.project, context.scope)?.firstOrNull()
        }
    }

    override fun getKey(): StubIndexKey<String, LuaDocTagAlias> {
        return StubKeys.ALIAS
    }
}