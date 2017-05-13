package com.service;

import java.util.List;

import com.entity.Tree;
import com.entity.SysUser;

public interface IMenuService {
	List<Tree> getMenuTree(SysUser user);
}
