// This is a generated file. Not intended for manual editing.
package com.tarantoollua.intellij.lua.psi.impl;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.lang.ASTNode;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.util.PsiTreeUtil;
import static com.tarantoollua.intellij.lua.psi.LuaTypes.*;
import com.tarantoollua.intellij.lua.psi.*;
import com.tarantoollua.intellij.lua.search.SearchContext;
import com.tarantoollua.intellij.lua.ty.ITy;
import com.tarantoollua.intellij.lua.stubs.LuaExprPlaceStub;
import com.intellij.psi.stubs.IStubElementType;
import com.intellij.psi.tree.IElementType;
import com.tarantoollua.intellij.lua.stubs.LuaExprStub;

public class LuaCallExprImpl extends LuaCallExprMixin implements LuaCallExpr {

  public LuaCallExprImpl(@NotNull LuaExprPlaceStub stub, @NotNull IStubElementType<?, ?> nodeType) {
    super(stub, nodeType);
  }

  public LuaCallExprImpl(@NotNull ASTNode node) {
    super(node);
  }

  public LuaCallExprImpl(@NotNull LuaExprPlaceStub stub, @NotNull IElementType type, @NotNull ASTNode node) {
    super(stub, type, node);
  }

  public void accept(@NotNull LuaVisitor visitor) {
    visitor.visitCallExpr(this);
  }

  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof LuaVisitor) accept((LuaVisitor)visitor);
    else super.accept(visitor);
  }

  @Override
  @NotNull
  public LuaArgs getArgs() {
    return notNullChild(PsiTreeUtil.getStubChildOfType(this, LuaArgs.class));
  }

  @Override
  @NotNull
  public LuaExpr getExpr() {
    return notNullChild(PsiTreeUtil.getStubChildOfType(this, LuaExpr.class));
  }

  @Override
  @NotNull
  public ITy guessParentType(@NotNull SearchContext context) {
    return LuaPsiImplUtilKt.guessParentType(this, context);
  }

  @Override
  @Nullable
  public PsiElement getFirstStringArg() {
    return LuaPsiImplUtilKt.getFirstStringArg(this);
  }

  @Override
  public boolean isMethodDotCall() {
    return LuaPsiImplUtilKt.isMethodDotCall(this);
  }

  @Override
  public boolean isMethodColonCall() {
    return LuaPsiImplUtilKt.isMethodColonCall(this);
  }

  @Override
  public boolean isFunctionCall() {
    return LuaPsiImplUtilKt.isFunctionCall(this);
  }

}
