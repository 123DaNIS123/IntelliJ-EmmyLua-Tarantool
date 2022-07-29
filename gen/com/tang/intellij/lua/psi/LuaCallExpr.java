// This is a generated file. Not intended for manual editing.
package com.tarantoollua.intellij.lua.psi;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.psi.PsiElement;
import com.intellij.psi.StubBasedPsiElement;
import com.tarantoollua.intellij.lua.stubs.LuaExprStub;
import com.tarantoollua.intellij.lua.search.SearchContext;
import com.tarantoollua.intellij.lua.ty.ITy;

public interface LuaCallExpr extends LuaExpr, StubBasedPsiElement<LuaExprStub> {

  @NotNull
  LuaArgs getArgs();

  @NotNull
  LuaExpr getExpr();

  @NotNull
  ITy guessParentType(@NotNull SearchContext context);

  @Nullable
  PsiElement getFirstStringArg();

  boolean isMethodDotCall();

  boolean isMethodColonCall();

  boolean isFunctionCall();

}
