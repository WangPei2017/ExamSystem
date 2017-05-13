package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.IMenuMapper;
import com.entity.Tree;
import com.entity.SysUser;
import com.service.IMenuService;
@Service
public class MenuServiceImpl implements IMenuService{
	@Autowired
	private IMenuMapper menuDao;
	
	
	public List<Tree> getMenuTree(SysUser user) {
		//如果是管理员，则可以看到全部菜单
		if("admin".equals(user.getName())){
			List<Tree> list=menuDao.getMenuTree();
			for(Tree tree:list){
				tree.setChildren(getChildren(tree.getId()));
			}
			return list;
		}else{
			//查询当前用户授权后的菜单
			List<Tree> list=menuDao.getAuthMenuTree(user);
			for(Tree tree:list){
				tree.setChildren(getAuthChildren(user.getId(),tree.getId()));
			}
			return list;
		}
	}
    private List<Tree> getChildren(String id){
    	List<Tree> list=menuDao.getTreeListByPid(id);
    	if(list.size()>0){
    		for(Tree tree:list){
    			tree.setChildren(getChildren(tree.getId()));
    		}
    	}
    	return list;
    }
    private List<Tree> getAuthChildren(String userId,String pId){
    	List<Tree> list=menuDao.getAuthMenuTreeByPid(userId,pId  );
    	if(list.size()>0){
    		for(Tree tree:list){
    			tree.setChildren(getAuthChildren(userId,tree.getId()));
    		}
    	}
    	return list;
    }
}
