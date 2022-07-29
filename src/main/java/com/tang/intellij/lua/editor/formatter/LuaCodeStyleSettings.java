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

package com.tarantoollua.intellij.lua.editor.formatter;

import com.intellij.psi.codeStyle.CodeStyleSettings;
import com.intellij.psi.codeStyle.CustomCodeStyleSettings;
import com.tarantoollua.intellij.lua.lang.LuaLanguage;

/**
 * LuaCodeStyleSettings
 * Created by tarantoolluazx on 2017/2/22.
 */
public class LuaCodeStyleSettings extends CustomCodeStyleSettings {

    public boolean SPACE_AFTER_TABLE_FIELD_SEP = true;
    public boolean SPACE_AROUND_BINARY_OPERATOR = true;
    public boolean SPACE_INSIDE_INLINE_TABLE = true;

    public boolean ALIGN_TABLE_FIELD_ASSIGN = false;

    LuaCodeStyleSettings(CodeStyleSettings container) {
        super(LuaLanguage.INSTANCE.getID(), container);
    }
}
