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

package com.tarantoollua.intellij.lua.lang;

import com.intellij.icons.AllIcons;
import com.intellij.openapi.util.IconLoader;
import com.intellij.ui.LayeredIcon;
import com.intellij.ui.RowIcon;

import javax.swing.*;

/**
 * Created by tarantoolluazx on 2015/11/15.
 * Email:love.tarantoolluazx@qq.com
 */
public class LuaIcons {

    private static Icon getIcon(String path) {
        return IconLoader.getIcon(path, LuaIcons.class);
    }

    public static final Icon FILE = getIcon("/icons/lua.png");
    public static final Icon CSHARP = getIcon("/icons/csharp.png");
    public static final Icon CPP = getIcon("/icons/cpp.png");
    public static final Icon CLASS = AllIcons.Nodes.Class;
    public static final Icon Alias = AllIcons.Nodes.AbstractClass;
    public static final Icon CLASS_FIELD = AllIcons.Nodes.Field;
    public static final Icon CLASS_METHOD = AllIcons.Nodes.Method;
    public static final Icon CLASS_METHOD_OVERRIDING = new RowIcon(AllIcons.Nodes.Method, AllIcons.Gutter.OverridingMethod);

    public static final Icon GLOBAL_FUNCTION = new LayeredIcon(AllIcons.Nodes.Function, AllIcons.Nodes.StaticMark);
    public static final Icon GLOBAL_VAR = new LayeredIcon(AllIcons.Nodes.Variable, AllIcons.Nodes.StaticMark);

    public static final Icon LOCAL_VAR = AllIcons.Nodes.Variable;
    public static final Icon LOCAL_FUNCTION = AllIcons.Nodes.Function;

    public static final Icon PARAMETER = AllIcons.Nodes.Parameter;
    public static final Icon WORD = AllIcons.Actions.Edit;
    public static final Icon ANNOTATION = getIcon("/icons/annotation.png");
    public static final Icon META_METHOD = getIcon("/icons/meta.png");

    public static final Icon PUBLIC = AllIcons.Nodes.C_public;
    public static final Icon PROTECTED = AllIcons.Nodes.C_protected;
    public static final Icon PRIVATE = AllIcons.Nodes.C_private;

    public static final Icon MODULE = getIcon("/icons/module.png");

    public static final Icon STRING_ARG_HISTORY = AllIcons.Vcs.History;

    public static final Icon LAYER = getIcon("/icons/lua_layer.svg");
    public static final Icon ROOT = getIcon("/icons/lua_root.svg");
    public static final Icon PROJECT = getIcon("/icons/lua_project.svg");

    public static final Icon STRING_LITERAL = AllIcons.Nodes.Aspect;

    public static class LineMarker {
        public static final Icon TailCall = getIcon("/icons/tail.png");
    }

    public static class Debugger {
        public static final Icon Console = getIcon("/icons/console.svg");
        public static final Icon StackFrame = getIcon("/icons/frame.svg");
        public static class Actions {
            public static final Icon PROFILER = AllIcons.Debugger.Db_primitive;
        }
    }
}
