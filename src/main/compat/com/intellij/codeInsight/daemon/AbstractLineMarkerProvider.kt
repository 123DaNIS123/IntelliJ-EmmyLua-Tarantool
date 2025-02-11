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

package com.intellij.codeInsight.daemon

import com.intellij.psi.PsiElement

abstract class AbstractLineMarkerProvider : LineMarkerProvider {
    override fun collectSlowLineMarkers(list: List<PsiElement>, collection: MutableCollection<in LineMarkerInfo<*>>) {
        collectSlowLineMarkersExt(list, collection)
    }

    abstract fun collectSlowLineMarkersExt(list: List<PsiElement>, collection: MutableCollection<in LineMarkerInfo<*>>)
}