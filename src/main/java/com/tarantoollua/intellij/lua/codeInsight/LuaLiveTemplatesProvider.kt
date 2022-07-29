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

package com.tarantoollua.intellij.lua.codeInsight

import com.intellij.codeInsight.template.impl.DefaultLiveTemplatesProvider

/**
 *
 * Created by tarantoolluazx on 2017/2/11.
 */
class LuaLiveTemplatesProvider : DefaultLiveTemplatesProvider {

    override fun getDefaultLiveTemplateFiles() = DEFAULT_TEMPLATES

    override fun getHiddenLiveTemplateFiles(): Array<String>? = emptyArray()

    companion object {
        private val DEFAULT_TEMPLATES = arrayOf("/liveTemplates/lua")
    }
}
