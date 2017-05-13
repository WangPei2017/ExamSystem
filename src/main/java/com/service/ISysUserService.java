package com.service;

import java.util.List;

import com.entity.PageBean;
import com.entity.SysUser;

public interface ISysUserService {
	Integer deleteUser(String id);

	Integer saveOrUpdateUser(SysUser user);

	List<SysUser> getAllUser(PageBean pageBean);

	SysUser getUserById(String id);

	Integer getUserCount(PageBean pageBean);

	Integer saveUserRole(String userId, String roleId);
}
