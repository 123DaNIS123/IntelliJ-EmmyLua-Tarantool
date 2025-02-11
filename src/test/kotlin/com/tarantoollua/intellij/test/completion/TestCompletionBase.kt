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

package com.tarantoollua.intellij.test.completion

import com.intellij.openapi.fileEditor.FileDocumentManager
import com.tarantoollua.intellij.lua.project.LuaSettings
import com.tarantoollua.intellij.test.LuaTestBase
import com.tarantoollua.intellij.test.fileTreeFromText

abstract class TestCompletionBase : LuaTestBase() {
    override fun getTestDataPath(): String {
        return "src/test/resources/completion"
    }

    fun doTestWithResult(result: String) {
        doTest {
            assertTrue(result in it)
        }
    }

    fun doTestWithResult(result: Collection<String>) {
        doTest {
            assertTrue(it.containsAll(result))
        }
    }

    fun doTest(action: (lookupStrings:List<String>) -> Unit) {
        LuaSettings.instance.isShowWordsInFile = false
        FileDocumentManager.getInstance().saveAllDocuments()
        myFixture.completeBasic()
        val strings = myFixture.lookupElementStrings
        assertNotNull(strings)
        action(strings!!)
    }

    fun doTest(code: String, action: (lookupStrings:List<String>) -> Unit) {
        fileTreeFromText(code).createAndOpenFileWithCaretMarker()
        doTest(action)
    }
}