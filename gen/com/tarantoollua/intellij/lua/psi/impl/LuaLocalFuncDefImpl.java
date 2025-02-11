// This is a generated file. Not intended for manual editing.
package com.tarantoollua.intellij.lua.psi.impl;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.lang.ASTNode;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.util.PsiTreeUtil;
import static com.tarantoollua.intellij.lua.psi.LuaTypes.*;
import com.intellij.extapi.psi.StubBasedPsiElementBase;
import com.tarantoollua.intellij.lua.stubs.LuaLocalFuncDefStub;
import com.tarantoollua.intellij.lua.psi.*;
import com.intellij.psi.search.SearchScope;
import com.tarantoollua.intellij.lua.comment.psi.api.LuaComment;
import com.tarantoollua.intellij.lua.search.SearchContext;
import com.tarantoollua.intellij.lua.ty.ITy;
import com.intellij.psi.stubs.IStubElementType;
import com.intellij.psi.tree.IElementType;

public class LuaLocalFuncDefImpl extends StubBasedPsiElementBase<LuaLocalFuncDefStub> implements LuaLocalFuncDef {

  public LuaLocalFuncDefImpl(@NotNull LuaLocalFuncDefStub stub, @NotNull IStubElementType type) {
    super(stub, type);
  }

  public LuaLocalFuncDefImpl(@NotNull ASTNode node) {
    super(node);
  }

  public LuaLocalFuncDefImpl(LuaLocalFuncDefStub stub, IElementType type, ASTNode node) {
    super(stub, type, node);
  }

  public void accept(@NotNull LuaVisitor visitor) {
    visitor.visitLocalFuncDef(this);
  }

  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof LuaVisitor) accept((LuaVisitor)visitor);
    else super.accept(visitor);
  }

  @Override
  @Nullable
  public LuaFuncBody getFuncBody() {
    return PsiTreeUtil.getStubChildOfType(this, LuaFuncBody.class);
  }

  @Override
  @Nullable
  public PsiElement getId() {
    return findChildByType(ID);
  }

  @Override
  @Nullable
  public LuaComment getComment() {
    return LuaPsiImplUtilKt.getComment(this);
  }

  @Override
  @NotNull
  public List<LuaParamNameDef> getParamNameDefList() {
    return LuaPsiImplUtilKt.getParamNameDefList(this);
  }

  @Override
  @Nullable
  public PsiElement getNameIdentifier() {
    return LuaPsiImplUtilKt.getNameIdentifier(this);
  }

  @Override
  @NotNull
  public PsiElement setName(@NotNull String name) {
    return LuaPsiImplUtilKt.setName(this, name);
  }

  @Override
  @Nullable
  public String getName() {
    return LuaPsiImplUtilKt.getName(this);
  }

  @Override
  public int getTextOffset() {
    return LuaPsiImplUtilKt.getTextOffset(this);
  }

  @Override
  @NotNull
  public SearchScope getUseScope() {
    return LuaPsiImplUtilKt.getUseScope(this);
  }

  @Override
  @NotNull
  public ITy guessReturnType(@NotNull SearchContext searchContext) {
    return LuaPsiImplUtilKt.guessReturnType(this, searchContext);
  }

  @Override
  @NotNull
  public LuaParamInfo[] getParams() {
    return LuaPsiImplUtilKt.getParams(this);
  }

}
