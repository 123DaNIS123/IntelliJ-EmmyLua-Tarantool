// This is a generated file. Not intended for manual editing.
package com.tarantoollua.intellij.lua.comment.psi.impl;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.lang.ASTNode;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.util.PsiTreeUtil;
import static com.tarantoollua.intellij.lua.comment.psi.LuaDocTypes.*;
import com.intellij.extapi.psi.ASTWrapperPsiElement;
import com.tarantoollua.intellij.lua.comment.psi.*;
import com.tarantoollua.intellij.lua.ty.ITy;

public class LuaDocTagReturnImpl extends ASTWrapperPsiElement implements LuaDocTagReturn {

  public LuaDocTagReturnImpl(@NotNull ASTNode node) {
    super(node);
  }

  public void accept(@NotNull LuaDocVisitor visitor) {
    visitor.visitTagReturn(this);
  }

  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof LuaDocVisitor) accept((LuaDocVisitor)visitor);
    else super.accept(visitor);
  }

  @Override
  @Nullable
  public LuaDocCommentString getCommentString() {
    return PsiTreeUtil.getChildOfType(this, LuaDocCommentString.class);
  }

  @Override
  @Nullable
  public LuaDocTypeList getTypeList() {
    return PsiTreeUtil.getChildOfType(this, LuaDocTypeList.class);
  }

  @Override
  @NotNull
  public ITy resolveTypeAt(int index) {
    return LuaDocPsiImplUtilKt.resolveTypeAt(this, index);
  }

  @Override
  @NotNull
  public ITy getType() {
    return LuaDocPsiImplUtilKt.getType(this);
  }

}
