package com.dao;

import java.util.List;
import java.util.Map;

import com.entity.PageBean;
import com.entity.SysUser;

public interface ISystemUserDaoMapper {

	Integer deleteUser(String id);
//	增加用户
	Integer addUser(SysUser user);
//	修改用户
	Integer updateUser(SysUser user);

	List<SysUser> getAllUser(PageBean pageBean);

	SysUser getUserById(String id);

	Integer getUserCount(PageBean pageBean);

	Integer deleteUserRole(String userId);

	Integer saveUserRole(Map<String, String> map);
}
