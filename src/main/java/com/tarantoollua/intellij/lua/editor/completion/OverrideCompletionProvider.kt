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

package com.tarantoollua.intellij.lua.editor.completion

import com.intellij.codeInsight.completion.CompletionParameters
import com.intellij.codeInsight.completion.CompletionResultSet
import com.intellij.codeInsight.lookup.LookupElementBuilder
import com.intellij.codeInsight.template.Template
import com.intellij.codeInsight.template.TemplateManager
import com.intellij.psi.util.PsiTreeUtil
import com.intellij.util.Processor
import com.tarantoollua.intellij.lua.lang.LuaIcons
import com.tarantoollua.intellij.lua.psi.*
import com.tarantoollua.intellij.lua.search.SearchContext
import com.tarantoollua.intellij.lua.stubs.index.LuaClassMemberIndex
import com.tarantoollua.intellij.lua.ty.ITyClass
import com.tarantoollua.intellij.lua.ty.TyClass
import com.tarantoollua.intellij.lua.ty.TyLazyClass

/**
 * override supper
 * Created by tarantoolluazx on 2016/12/25.
 */
class OverrideCompletionProvider : LuaCompletionProvider() {
    override fun addCompletions(session: CompletionSession) {
        val completionParameters = session.parameters
        val completionResultSet = session.resultSet
        val id = completionParameters.position
        val methodDef = PsiTreeUtil.getParentOfType(id, LuaClassMethodDef::class.java)
        if (methodDef != null) {
            val context = SearchContext.get(methodDef.project)
            val classType = methodDef.guessClassType(context)
            if (classType != null) {
                val memberNameSet = mutableSetOf<String>()
                classType.processMembers(context, { _, m ->
                    m.name?.let { memberNameSet.add(it) }
                }, false)
                TyClass.processSuperClass(classType, context) { sup ->
                    addOverrideMethod(completionParameters, completionResultSet, memberNameSet, sup)
                    true
                }
            }
        }
    }

    private fun addOverrideMethod(completionParameters: CompletionParameters, completionResultSet: CompletionResultSet, memberNameSet:MutableSet<String>, sup: ITyClass) {
        val project = completionParameters.originalFile.project
        val context = SearchContext.get(project)
        val clazzName = sup.className
        LuaClassMemberIndex.processAll(TyLazyClass(clazzName), context, Processor { def ->
            if (def is LuaClassMethod) {
                def.name?.let {
                    if (memberNameSet.add(it)) {
                        val elementBuilder = LookupElementBuilder.create(def.name!!)
                                .withIcon(LuaIcons.CLASS_METHOD_OVERRIDING)
                                .withInsertHandler(OverrideInsertHandler(def))
                                .withTailText(def.paramSignature)

                        completionResultSet.addElement(elementBuilder)
                    }
                }
            }
            true
        })
    }

    internal class OverrideInsertHandler(funcBodyOwner: LuaFuncBodyOwner) : FuncInsertHandler(funcBodyOwner) {

        override val autoInsertParameters = true

        override fun createTemplate(manager: TemplateManager, paramNameDefList: Array<LuaParamInfo>): Template {
            val template = super.createTemplate(manager, paramNameDefList)
            template.addEndVariable()
            template.addTextSegment("\nend")
            return template
        }
    }
}
