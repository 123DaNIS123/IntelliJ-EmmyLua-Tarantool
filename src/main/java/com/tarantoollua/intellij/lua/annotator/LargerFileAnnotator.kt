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

package com.tarantoollua.intellij.lua.annotator

import com.intellij.lang.annotation.AnnotationHolder
import com.intellij.lang.annotation.Annotator
import com.intellij.lang.annotation.HighlightSeverity
import com.intellij.openapi.util.text.StringUtil
import com.intellij.psi.PsiElement
import com.tarantoollua.intellij.lua.project.LuaSettings
import com.tarantoollua.intellij.lua.psi.LuaPsiFile

class LargerFileAnnotator : Annotator {
    override fun annotate(psiElement: PsiElement, annotationHolder: AnnotationHolder) {
        if (psiElement is LuaPsiFile && psiElement.tooLarger) {
            val file = psiElement.virtualFile
            val fileLimit = StringUtil.formatFileSize(LuaSettings.instance.tooLargerFileThreshold * 1024L)
            val fileSize = StringUtil.formatFileSize(file.length)
            annotationHolder
                .newAnnotation(
                    HighlightSeverity.WARNING,
                    "The file size ($fileSize) exceeds configured limit ($fileLimit). Code insight features are not available."
                )
                .range(psiElement)
                .fileLevel()
                .create()
        }
    }
}