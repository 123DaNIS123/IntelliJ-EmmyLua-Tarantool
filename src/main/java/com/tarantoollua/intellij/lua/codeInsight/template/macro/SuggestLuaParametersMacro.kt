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

package com.tarantoollua.intellij.lua.codeInsight.template.macro

import com.intellij.codeInsight.lookup.LookupElement
import com.intellij.codeInsight.lookup.LookupElementBuilder
import com.intellij.codeInsight.template.Expression
import com.intellij.codeInsight.template.ExpressionContext
import com.intellij.codeInsight.template.Macro
import com.intellij.codeInsight.template.Result
import com.tarantoollua.intellij.lua.psi.*
import com.tarantoollua.intellij.lua.search.SearchContext
import com.tarantoollua.intellij.lua.ty.ITyFunction

class SuggestLuaParametersMacro(private val position: Position = Position.TemplateHandler) : Macro() {

    enum class Position {
        TemplateHandler, KeywordInsertHandler, TypedHandler
    }

    override fun getPresentableName(): String {
        return "SuggestLuaParameters()"
    }

    override fun getName(): String {
        return "SuggestLuaParameters"
    }

    override fun calculateResult(expressions: Array<Expression>, expressionContext: ExpressionContext): Result? {

        return null
    }

    override fun calculateLookupItems(expressions: Array<out Expression>, context: ExpressionContext): Array<LookupElement>? {
        val element = context.psiElementAtStartOffset
        val next = element?.nextSibling
        val func = when (position) {
            Position.TypedHandler,
            Position.KeywordInsertHandler -> next?.parent
            else -> next
        }

        if (func is LuaClosureExpr) {
            val ty = func.shouldBe(SearchContext.get(context.project)) as? ITyFunction ?: return null
            return create(ty.mainSignature.params)
        } else if (func is LuaClassMethod) {
            val method = func.findOverridingMethod(SearchContext.get(context.project))
            val params = method?.params
            if (params != null)
                return create(params)
        }

        return null
    }

    private fun create(params: Array<LuaParamInfo>): Array<LookupElement> {
        val paramNames = mutableListOf<String>()
        params.forEach {
            paramNames.add(it.name)
        }
        val builder = LookupElementBuilder.create(paramNames.joinToString(", "))
        return arrayOf(builder)
    }
}