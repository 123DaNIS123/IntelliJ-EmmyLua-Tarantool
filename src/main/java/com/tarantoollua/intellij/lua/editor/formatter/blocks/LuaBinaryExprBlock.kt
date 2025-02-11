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

package com.tarantoollua.intellij.lua.editor.formatter.blocks

import com.intellij.formatting.*
import com.intellij.psi.PsiElement
import com.intellij.psi.tree.TokenSet
import com.tarantoollua.intellij.lua.editor.formatter.LuaFormatContext
import com.tarantoollua.intellij.lua.psi.LuaBinaryExpr
import com.tarantoollua.intellij.lua.psi.LuaTypes.*

/**
 * binary
 * Created by tarantoolluazx on 2017/4/23.
 */
class LuaBinaryExprBlock internal constructor(psi: LuaBinaryExpr,
                                              wrap: Wrap?,
                                              alignment: Alignment?,
                                              indent: Indent,
                                              ctx: LuaFormatContext)
    : LuaScriptBlock(psi, wrap, alignment, indent, ctx) {

    companion object {
        //这几个特殊一点，前后必须要有空格
        private val AND_NOT_OR = TokenSet.create(AND, NOT, OR)
    }

    override fun buildChild(child: PsiElement, indent: Indent?) =
            super.buildChild(child, Indent.getContinuationWithoutFirstIndent())

    override fun getSpacing(child1: Block?, child2: Block): Spacing? {
        if (child1 is LuaScriptBlock && child2 is LuaScriptBlock) {
            if (child1.node.findChildByType(AND_NOT_OR) != null || child2.node.findChildByType(AND_NOT_OR) != null)
                return Spacing.createSpacing(1, 1, 0, true, 1)
        }
        return super.getSpacing(child1, child2)
    }
}