package com.service;

import java.util.List;

import com.entity.PageBean;
import com.entity.Role;
import com.entity.Tree;

public interface IRoleService {
	List<Role> getAllRole(PageBean pageBean);
	String getRoleIdByUserId(String userId);
	Integer getRoleCount(PageBean pageBean);
	Integer saveOrUpdateRole(Role role);
	Integer deleteRole(String id);
	List<Tree> getMenuAuthTree(String roleId);
	Integer updateRoleMenu(String menuId,String roleId);
}
