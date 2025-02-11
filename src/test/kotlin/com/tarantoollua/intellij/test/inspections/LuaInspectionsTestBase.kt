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

package com.tarantoollua.intellij.test.inspections

import com.tarantoollua.intellij.test.LuaTestBase
import com.intellij.codeInspection.LocalInspectionTool
import org.intellij.lang.annotations.Language

abstract class LuaInspectionsTestBase(private val inspection: LocalInspectionTool) : LuaTestBase() {
    private fun enableInspection() =
            myFixture.enableInspections(inspection.javaClass)

    protected fun checkByText(
            @Language("Lua") text: String,
            checkWarn: Boolean = true, checkInfo: Boolean = false, checkWeakWarn: Boolean = false) {
        myFixture.configureByText("main.lua", text)
        enableInspection()
        myFixture.checkHighlighting(checkWarn, checkInfo, checkWeakWarn)
    }
}