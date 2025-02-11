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
import com.tarantoollua.intellij.lua.stubs.LuaPlaceholderStub;
import com.tarantoollua.intellij.lua.psi.*;
import com.intellij.psi.stubs.IStubElementType;
import com.intellij.psi.tree.IElementType;

public class LuaNameListImpl extends StubBasedPsiElementBase<LuaPlaceholderStub> implements LuaNameList {

  public LuaNameListImpl(@NotNull LuaPlaceholderStub stub, @NotNull IStubElementType type) {
    super(stub, type);
  }

  public LuaNameListImpl(@NotNull ASTNode node) {
    super(node);
  }

  public LuaNameListImpl(LuaPlaceholderStub stub, IElementType type, ASTNode node) {
    super(stub, type, node);
  }

  public void accept(@NotNull LuaVisitor visitor) {
    visitor.visitNameList(this);
  }

  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof LuaVisitor) accept((LuaVisitor)visitor);
    else super.accept(visitor);
  }

  @Override
  @NotNull
  public List<LuaAttribute> getAttributeList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, LuaAttribute.class);
  }

  @Override
  @NotNull
  public List<LuaNameDef> getNameDefList() {
    return PsiTreeUtil.getStubChildrenOfTypeAsList(this, LuaNameDef.class);
  }

}
