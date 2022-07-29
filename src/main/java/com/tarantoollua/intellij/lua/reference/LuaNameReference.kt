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

package com.tarantoollua.intellij.lua.reference

import com.intellij.openapi.util.TextRange
import com.intellij.psi.PsiElement
import com.intellij.psi.PsiReferenceBase
import com.intellij.util.IncorrectOperationException
import com.tarantoollua.intellij.lua.psi.LuaElementFactory
import com.tarantoollua.intellij.lua.psi.LuaNameExpr
import com.tarantoollua.intellij.lua.psi.resolve
import com.tarantoollua.intellij.lua.search.SearchContext

/**
 *
 * Created by tarantoolluazx on 2016/11/26.
 */
class LuaNameReference internal constructor(element: LuaNameExpr) : PsiReferenceBase<LuaNameExpr>(element), LuaReference {
    private val id: PsiElement = element.id

    override fun getRangeInElement(): TextRange {
        val start = id.textOffset - myElement.textOffset
        return TextRange(start, start + id.textLength)
    }

    @Throws(IncorrectOperationException::class)
    override fun handleElementRename(newElementName: String): PsiElement {
        val newId = LuaElementFactory.createIdentifier(myElement.project, newElementName)
        id.replace(newId)
        return newId
    }

    override fun resolve(): PsiElement? {
        return resolve(SearchContext.get(myElement.project))
    }

    override fun resolve(context: SearchContext): PsiElement? {
        val resolve = resolve(myElement, context)
        return if (resolve === myElement) null else resolve
    }

    override fun isReferenceTo(element: PsiElement): Boolean {
        return myElement.manager.areElementsEquivalent(element, resolve())
    }

    override fun getVariants(): Array<Any> {
        return emptyArray()
    }
}
