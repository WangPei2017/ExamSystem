package com.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.SysUser;
import com.entity.Tree;
import com.service.IMenuService;

import net.sf.json.JSONArray;
//菜单
@Controller
@RequestMapping(value = "/menu")
public class MenuController {
	@Autowired
	private IMenuService menuService;
	@RequestMapping("/menuManage")
	public String menuManage(){
		return "menuManage";
	}
	@RequestMapping(value="/getMenuTree",method=RequestMethod.POST)
	@ResponseBody
	public String getMenuTree(HttpSession session,HttpServletResponse response ){
		response.setContentType("application/json;charset=UTF-8");//防止数据传递乱码
		SysUser user=(SysUser) session.getAttribute("userinfo");	
		//查询菜单
		List<Tree> list=menuService.getMenuTree(user);	
		JSONArray json=JSONArray.fromObject(list);
		String str=json.toString();
		return str;
	}
}
