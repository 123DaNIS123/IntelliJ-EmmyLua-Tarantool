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
import com.tarantoollua.intellij.lua.psi.LuaAssignStat
import com.tarantoollua.intellij.lua.psi.LuaIndexExpr
import com.tarantoollua.intellij.lua.psi.LuaVisitor
import com.tarantoollua.intellij.lua.search.SearchContext
import com.tarantoollua.intellij.lua.ty.Ty
import com.tarantoollua.intellij.lua.ty.TyClass

class AssignTypeInspection : StrictInspection() {
    override fun buildVisitor(myHolder: ProblemsHolder, isOnTheFly: Boolean, session: LocalInspectionToolSession): PsiElementVisitor =
            object : LuaVisitor() {
                override fun visitAssignStat(o: LuaAssignStat) {
                    super.visitAssignStat(o)

                    val assignees = o.varExprList.exprList
                    val values = o.valueExprList?.exprList ?: listOf()
                    val searchContext = SearchContext.get(o.project)

                    // Check right number of fields/assignments
                    if (assignees.size > values.size) {
                        for (i in values.size until assignees.size) {
                            myHolder.registerProblem(assignees[i], "Missing value assignment.")
                        }
                    } else if (assignees.size < values.size) {
                        for (i in assignees.size until values.size) {
                            myHolder.registerProblem(values[i], "Nothing to assign to.")
                        }
                    } else {
                        // Try to match types for each assignment
                        for (i in 0 until assignees.size) {
                            val field = assignees[i]
                            val name = field.name ?: ""
                            val value = values[i]
                            val valueType = value.guessType(searchContext)

                            // Field access
                            if (field is LuaIndexExpr) {
                                // Get owner class
                                val parent = field.guessParentType(searchContext)

                                if (parent is TyClass) {
                                    val fieldType = parent.findMemberType(name, searchContext) ?: Ty.NIL

                                    if (!valueType.subTypeOf(fieldType, searchContext, false)) {
                                        myHolder.registerProblem(value, "Type mismatch. Required: '%s' Found: '%s'".format(fieldType, valueType))
                                    }
                                }
                            } else {
                                // Local/global var assignments, only check type if there is no comment defining it
                                if (o.comment == null) {
                                    val fieldType = field.guessType(searchContext)

                                    if (!valueType.subTypeOf(fieldType, searchContext, false)) {
                                        myHolder.registerProblem(value, "Type mismatch. Required: '%s' Found: '%s'".format(fieldType, valueType))
                                    }
                                }
                            }
                        }
                    }
                }
            }
}