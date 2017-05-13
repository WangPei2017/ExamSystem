package com.dao;

import java.util.List;

import com.entity.SysUser;
import com.entity.Tree;

public interface IMenuMapper {
	List<Tree> getMenuTree();
	List<Tree> getTreeListByPid(String id);
	List<Tree> getAuthMenuTree(SysUser user);
	List<Tree> getAuthMenuTreeByPid(String userId, String pId);
}
