// This is a generated file. Not intended for manual editing.
package com.tarantoollua.intellij.lua.comment.psi;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.psi.PsiElement;
import com.tarantoollua.intellij.lua.psi.LuaTypeAlias;
import com.intellij.psi.PsiNameIdentifierOwner;
import com.intellij.psi.StubBasedPsiElement;
import com.tarantoollua.intellij.lua.stubs.LuaDocTagAliasStub;
import com.tarantoollua.intellij.lua.ty.ITy;

public interface LuaDocTagAlias extends LuaTypeAlias, LuaDocPsiElement, PsiNameIdentifierOwner, LuaDocTag, StubBasedPsiElement<LuaDocTagAliasStub> {

  @Nullable
  LuaDocTy getTy();

  @Nullable
  PsiElement getId();

  @Nullable
  PsiElement getNameIdentifier();

  @NotNull
  PsiElement setName(@NotNull String newName);

  @Nullable
  String getName();

  int getTextOffset();

  @NotNull
  ITy getType();

}
