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

package com.tarantoollua.intellij.lua.psi;

import com.tarantoollua.intellij.lua.search.SearchContext;
import com.tarantoollua.intellij.lua.ty.ITy;
import com.tarantoollua.intellij.lua.ty.TyAliasSubstitutor;

/**
 *
 * Created by tarantoolluazx on 2016/12/1.
 */
public interface LuaTypeGuessable extends LuaPsiElement {
    default ITy guessType(SearchContext context) {
        ITy ty = SearchContext.Companion.infer(this, context);
        ty = TyAliasSubstitutor.Companion.substitute(ty, context);
        return ty;
    }
}