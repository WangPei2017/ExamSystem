package com.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.entity.PageBean;
import com.entity.Role;
import com.entity.Tree;

@Repository
public interface IRoleMapper {
	// 分页
	List<Role> getAllRole(PageBean pageBean);

	// 不分页
	List<Role> getAllRole();

	Integer getRoleCount(PageBean pageBean);

	String getRoleIdByUserId(String userId);

	Integer updateRole(Role role);

	Integer addRole(Role role);

	Integer addRoleMenu(String roleId, String menuId);

	Integer deleteRole(String id);

	Integer deleteRoleMenu(String id);

	List<Tree> getParentMenuAuthTree();

	List<Tree> getMenuAuthTreeByParentId(String id, String roleId);

}
