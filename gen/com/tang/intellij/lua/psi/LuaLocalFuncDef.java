// This is a generated file. Not intended for manual editing.
package com.tarantoollua.intellij.lua.psi;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiNameIdentifierOwner;
import com.intellij.psi.StubBasedPsiElement;
import com.tarantoollua.intellij.lua.stubs.LuaLocalFuncDefStub;
import com.intellij.psi.search.SearchScope;
import com.tarantoollua.intellij.lua.comment.psi.api.LuaComment;
import com.tarantoollua.intellij.lua.search.SearchContext;
import com.tarantoollua.intellij.lua.ty.ITy;

public interface LuaLocalFuncDef extends LuaFuncBodyOwner, LuaDeclaration, LuaStatement, PsiNameIdentifierOwner, StubBasedPsiElement<LuaLocalFuncDefStub> {

  @Nullable
  LuaFuncBody getFuncBody();

  @Nullable
  PsiElement getId();

  @Nullable
  LuaComment getComment();

  @NotNull
  List<LuaParamNameDef> getParamNameDefList();

  @Nullable
  PsiElement getNameIdentifier();

  @NotNull
  PsiElement setName(@NotNull String name);

  @Nullable
  String getName();

  int getTextOffset();

  @NotNull
  SearchScope getUseScope();

  @NotNull
  ITy guessReturnType(@NotNull SearchContext searchContext);

  @NotNull
  LuaParamInfo[] getParams();

}
