package com.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ISystemLoginMapper;
import com.entity.SysUser;
import com.service.ISystemLoginService;


@Service
public class SystemLoginServiceImpl implements ISystemLoginService{
	@Autowired
	private ISystemLoginMapper loginDao;
	
	
	public void setLoginDao(ISystemLoginMapper loginDao) {
		this.loginDao = loginDao;
	}


	public SysUser getUserInfo(SysUser user) {
		SysUser u=loginDao.getUserInfo(user);
		
		return u;
	}

}
