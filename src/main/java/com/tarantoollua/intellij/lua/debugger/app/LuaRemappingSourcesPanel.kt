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

package com.tarantoollua.intellij.lua.debugger.app

import com.intellij.openapi.fileChooser.FileChooser
import com.intellij.openapi.fileChooser.FileChooserDescriptor
import com.intellij.ui.IdeBorderFactory
import com.intellij.ui.ToolbarDecorator
import com.intellij.ui.table.JBTable
import java.awt.BorderLayout
import javax.swing.JPanel
import javax.swing.table.DefaultTableModel

class LuaRemappingSourcesPanel : JPanel(BorderLayout()) {
//    private val dataModel = DefaultListModel<String>()
//    private val pathList = JBList(dataModel)

    private val dataTableModel = DefaultTableModel(0, 2)

    private val pathTable = JBTable(dataTableModel)
    @Override
    fun isCellEditable(row: Int, column: Int): Boolean {
        return column == 0
    }


    init {
//        pathList.selectionMode = ListSelectionModel.SINGLE_SELECTION

//        add(ToolbarDecorator.createDecorator(pathList)
//                .setAddAction { addPath() }
//                .setEditAction { editPath() }
//                .setRemoveAction { removePath() }
//                .createPanel(), BorderLayout.CENTER)
//        border = IdeBorderFactory.createTitledBorder(LuaBundle.message("ui.settings.additional_root"), false)

        pathTable.tableHeader.columnModel.getColumn(0).headerValue = "@builtin"
        pathTable.tableHeader.columnModel.getColumn(1).headerValue = "Remapped"
        pathTable.tableHeader.reorderingAllowed = false

        add(ToolbarDecorator.createDecorator(pathTable)
                .setAddAction { addPath() }
                .setEditAction { editPath() }
                .setRemoveAction { removePath() }
                .createPanel(), BorderLayout.CENTER)
        border = IdeBorderFactory.createTitledBorder("Debugger remapping sources", false)
    }

//    var roots: Array<String> get() {
//        val list = mutableListOf<String>()
//        for (i in 0 until dataModel.size) {
//            list.add(dataModel.get(i))
//        }
//        return list.toTypedArray()
//    } set(value) {
//        dataModel.clear()
//        for (s in value) dataModel.addElement(s)
//    }


    var srcs: ArrayList<Pair<String, String>> get() {
        val tempSrcs = ArrayList<Pair<String, String>>()
        var tempPair: Pair<String, String>
        for (i in 0 until dataTableModel.rowCount) {
            tempPair = Pair(dataTableModel.getValueAt(i, 0) as String, dataTableModel.getValueAt(i, 1) as String)
            tempSrcs.add(tempPair)
        }
        // val tempStr = tempSrcs.toString()
        return tempSrcs
    } set(value) {
        for (i in 0 until dataTableModel.rowCount) {
            dataTableModel.removeRow(0)
        }
        for (s:Pair<String, String> in value) {
            dataTableModel.addRow(arrayOf(s.first, s.second))
        }
    }
//    var srcs: ArrayList<String> get() {
//        val tempSrcs = ArrayList<String>()
//        var temp = ""
//        for (i in 0 until dataTableModel.rowCount) {
//            temp = dataTableModel.getValueAt(i, 0) as String + "\t" + dataTableModel.getValueAt(i, 1) as String
//            tempSrcs.add(temp)
//        }
//        return tempSrcs
//    } set(value) {
//        for (i in 0 until dataTableModel.rowCount) {
//            dataTableModel.removeRow(0)
//        }
//        for (s in value) {
//            dataTableModel.addRow(arrayOf(s[0:s.find], "22"))
//        }
//    }




    private fun addPath() {
        dataTableModel.addRow(arrayOf("builtin", "path/to/tarantool/src/lua"))
}

private fun editPath() {
    val index = pathTable.selectedRow
    val desc = FileChooserDescriptor(false, true, false, false, false, false)
    val dir = FileChooser.chooseFile(desc, null, null)
    if (dir != null) {
        // dataModel.set(index, dir.canonicalPath)
        dataTableModel.setValueAt(dir.canonicalPath, index, 1)
    }
}

private fun removePath() {
    // val index = pathList.selectedIndex
    // dataModel.removeElementAt(index)
    val index = pathTable.selectedRow
    dataTableModel.removeRow(index)
}
}