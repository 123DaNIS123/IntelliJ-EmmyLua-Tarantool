// This is a generated file. Not intended for manual editing.
package com.tarantoollua.intellij.lua.psi;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.psi.PsiElement;
import com.tarantoollua.intellij.lua.stubs.LuaExprStubElement;
import com.tarantoollua.intellij.lua.stubs.LuaClosureExprStub;
import com.tarantoollua.intellij.lua.search.SearchContext;
import com.tarantoollua.intellij.lua.ty.ITy;

public interface LuaClosureExpr extends LuaExpr, LuaFuncBodyOwner, LuaExprStubElement<LuaClosureExprStub> {

  @Nullable
  LuaFuncBody getFuncBody();

  @NotNull
  List<LuaParamNameDef> getParamNameDefList();

  @NotNull
  ITy guessReturnType(@NotNull SearchContext searchContext);

  @NotNull
  LuaParamInfo[] getParams();

}
