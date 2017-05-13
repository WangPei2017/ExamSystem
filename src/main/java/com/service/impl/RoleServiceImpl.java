package com.service.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dao.IRoleMapper;
import com.entity.PageBean;
import com.entity.Role;
import com.entity.Tree;
import com.service.IRoleService;

@Service
public class RoleServiceImpl implements IRoleService {
	@Autowired
	private IRoleMapper roleMapper;
	
	public List<Role> getAllRole(PageBean pageBean) {
		if (pageBean!=null) {
//			调用分页
			return roleMapper.getAllRole(pageBean);
		}else{
			return roleMapper.getAllRole();
		}
	}

	
	public String getRoleIdByUserId(String userId) {
		return roleMapper.getRoleIdByUserId(userId);
	}

	
	public Integer getRoleCount(PageBean pageBean) {
		return roleMapper.getRoleCount(pageBean);
	}
	
	// propagation=Propagation.REQUIRED 事务传播属性
	// Isolation.READ_COMMITTED 事务隔离级别
	// timeout 超时时间
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, isolation = Isolation.READ_COMMITTED, timeout = 5)
	
	public Integer saveOrUpdateRole(Role role) {
		
		if (StringUtils.isNotEmpty(role.getId())) {
			return roleMapper.updateRole(role);
		}else{
			return roleMapper.addRole(role);
		}
	}
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, isolation = Isolation.READ_COMMITTED, timeout = 5)
	
	public Integer deleteRole(String id) {
		roleMapper.deleteRoleMenu(id);
		return roleMapper.deleteRole(id);
	}

	
	public List<Tree> getMenuAuthTree(String roleId) {
		List<Tree> list = roleMapper.getParentMenuAuthTree();
		for(Tree tree:list){
			tree.setChildren(getChildren(tree.getId(),roleId));
		}
		return list;
	}
	public List<Tree> getChildren(String id,String roleId){
		List<Tree> childrenList= roleMapper.getMenuAuthTreeByParentId(id, roleId);
		if(childrenList!=null&&childrenList.size()>0){
			for (Tree tree:childrenList) {
				boolean checked = "true".equals(tree.getAttributes()) ? true: false;
				tree.setChecked(checked);
				getChildren(tree.getId(),roleId);
			}
		}
		return childrenList;
	}
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	
	public Integer updateRoleMenu(String menuId, String roleId) {
		//先删除该角色下对应的所有菜单项
		int n = roleMapper.deleteRoleMenu(roleId);
		if(StringUtils.isNotEmpty(menuId)){
			String[] mids = menuId.split("\\|");
			for (int  i= 0;  i< mids.length; i++) {
				roleMapper.addRoleMenu(roleId, mids[i]);
				n++;
			}
		}
		return n;
	}
}
