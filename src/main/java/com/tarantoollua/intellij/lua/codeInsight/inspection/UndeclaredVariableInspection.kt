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

package com.tarantoollua.intellij.lua.codeInsight.inspection

import com.intellij.codeInspection.LocalInspectionToolSession
import com.intellij.codeInspection.ProblemsHolder
import com.intellij.psi.PsiElementVisitor
import com.tarantoollua.intellij.lua.psi.LuaNameExpr
import com.tarantoollua.intellij.lua.psi.LuaVisitor
import com.tarantoollua.intellij.lua.psi.resolve
import com.tarantoollua.intellij.lua.search.SearchContext

class UndeclaredVariableInspection : StrictInspection() {
    override fun buildVisitor(myHolder: ProblemsHolder, isOnTheFly: Boolean, session: LocalInspectionToolSession): PsiElementVisitor =
            object : LuaVisitor() {
                override fun visitNameExpr(o: LuaNameExpr) {
                    super.visitNameExpr(o)
                    val res = resolve(o, SearchContext.get(o.project))

                    if (res == null) {
                        myHolder.registerProblem(o, "Undeclared variable '%s'.".format(o.text))
                    }
                }
            }
}