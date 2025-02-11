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

package com.tarantoollua.intellij.lua.highlighting

import com.intellij.lexer.FlexAdapter
import com.intellij.lexer.LayeredLexer
import com.intellij.lexer.MergingLexerAdapter
import com.intellij.psi.tree.IElementType
import com.intellij.psi.tree.TokenSet
import com.tarantoollua.intellij.lua.comment.lexer.LuaDocLexerAdapter
import com.tarantoollua.intellij.lua.lexer.LuaLexerAdapter
import com.tarantoollua.intellij.lua.lexer.LuaRegionLexer
import com.tarantoollua.intellij.lua.lexer._LuaStringLexer
import com.tarantoollua.intellij.lua.psi.LuaElementType
import com.tarantoollua.intellij.lua.psi.LuaTypes

/**
 * for highlight
 * Created by tarantoolluazx on 2016/11/29.
 */
internal class LuaFileLexer : LayeredLexer(LuaLexerAdapter()) {
    init {
        val docLexer = LayeredLexer(LuaDocLexerAdapter())
        //HtmlHighlightingLexer htmlLexer = new HtmlHighlightingLexer(null);
        //htmlLexer.setHasNoEmbeddments(true);
        //docLexer.registerSelfStoppingLayer(htmlLexer, new IElementType[] {LuaDocTypes.STRING}, IElementType.EMPTY_ARRAY);
        registerSelfStoppingLayer(docLexer, arrayOf<IElementType>(LuaElementType.DOC_COMMENT), IElementType.EMPTY_ARRAY)

        val stringLexer = MergingLexerAdapter(FlexAdapter(_LuaStringLexer()), TokenSet.create(LuaTypes.STRING))
        registerSelfStoppingLayer(stringLexer, arrayOf(LuaTypes.STRING), IElementType.EMPTY_ARRAY)

        registerSelfStoppingLayer(LuaRegionLexer(), arrayOf(LuaTypes.REGION, LuaTypes.ENDREGION), IElementType.EMPTY_ARRAY)
    }
}
