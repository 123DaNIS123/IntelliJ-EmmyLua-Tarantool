// This is a generated file. Not intended for manual editing.
package com.tarantoollua.intellij.lua.comment.psi.impl;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.lang.ASTNode;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.util.PsiTreeUtil;
import static com.tarantoollua.intellij.lua.comment.psi.LuaDocTypes.*;
import com.tarantoollua.intellij.lua.comment.psi.*;
import com.tarantoollua.intellij.lua.ty.ITy;

public class LuaDocGenericTyImpl extends LuaDocTyImpl implements LuaDocGenericTy {

  public LuaDocGenericTyImpl(@NotNull ASTNode node) {
    super(node);
  }

  public void accept(@NotNull LuaDocVisitor visitor) {
    visitor.visitGenericTy(this);
  }

  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof LuaDocVisitor) accept((LuaDocVisitor)visitor);
    else super.accept(visitor);
  }

  @Override
  @NotNull
  public List<LuaDocTy> getTyList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, LuaDocTy.class);
  }

  @Override
  @NotNull
  public ITy getType() {
    return LuaDocPsiImplUtilKt.getType(this);
  }

}
