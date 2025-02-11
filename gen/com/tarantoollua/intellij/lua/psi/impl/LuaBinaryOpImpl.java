// This is a generated file. Not intended for manual editing.
package com.tarantoollua.intellij.lua.psi.impl;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.lang.ASTNode;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.util.PsiTreeUtil;
import static com.tarantoollua.intellij.lua.psi.LuaTypes.*;
import com.intellij.extapi.psi.ASTWrapperPsiElement;
import com.tarantoollua.intellij.lua.psi.*;

public class LuaBinaryOpImpl extends ASTWrapperPsiElement implements LuaBinaryOp {

  public LuaBinaryOpImpl(@NotNull ASTNode node) {
    super(node);
  }

  public void accept(@NotNull LuaVisitor visitor) {
    visitor.visitBinaryOp(this);
  }

  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof LuaVisitor) accept((LuaVisitor)visitor);
    else super.accept(visitor);
  }

}
