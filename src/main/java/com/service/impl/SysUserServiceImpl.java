package com.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dao.ISystemUserDaoMapper;
import com.entity.PageBean;
import com.entity.SysUser;
import com.service.ISysUserService;
import com.util.MD5;


@Service
public class SysUserServiceImpl implements ISysUserService {
	@Autowired
	private ISystemUserDaoMapper userDao;
	

	public void setUserDao(ISystemUserDaoMapper userDao) {
		this.userDao = userDao;
	}

	public Integer deleteUser(String id) {
		return userDao.deleteUser(id);
	}

	@Transactional(isolation = Isolation.READ_COMMITTED, timeout = 10, propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public Integer saveOrUpdateUser(SysUser user) {
//		将密码进行加密
		String encPassword = MD5.encodeMD5(user.getName(), user.getPassword());
//		将密码设置为密文
		user.setPassword(encPassword);
		Integer n =0;
		if (user!=null&&StringUtils.isNotEmpty(user.getId())) {
			n = userDao.updateUser(user);
		}else if(user!=null&&StringUtils.isEmpty(user.getId())){
			n=userDao.addUser(user);
		}
		return n;
	}

	public List<SysUser> getAllUser(PageBean pageBean) {
		return userDao.getAllUser(pageBean);
	}

	
	public SysUser getUserById(String id) {
		return userDao.getUserById(id);
	}

	
	public Integer getUserCount(PageBean pageBean) {
		return userDao.getUserCount(pageBean);
	}

	@Transactional(propagation=Propagation.REQUIRED,timeout=10,isolation=Isolation.READ_COMMITTED,rollbackFor=Exception.class)
	
	public Integer saveUserRole(String userId, String roleId) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("userId", userId);
		map.put("roleId", roleId);
		userDao.deleteUserRole(userId);
		return userDao.saveUserRole(map);
	}

	public Integer deleteUser(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}

	public SysUser getUserById(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}

}
