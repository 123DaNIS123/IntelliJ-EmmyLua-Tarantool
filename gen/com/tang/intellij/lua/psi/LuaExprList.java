// This is a generated file. Not intended for manual editing.
package com.tarantoollua.intellij.lua.psi;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.psi.PsiElement;
import com.intellij.psi.StubBasedPsiElement;
import com.tarantoollua.intellij.lua.stubs.LuaPlaceholderStub;
import com.tarantoollua.intellij.lua.search.SearchContext;
import com.tarantoollua.intellij.lua.ty.ITy;

public interface LuaExprList extends LuaPsiElement, StubBasedPsiElement<LuaPlaceholderStub> {

  @NotNull
  List<LuaExpr> getExprList();

  @NotNull
  ITy guessTypeAt(@NotNull SearchContext context);

}
