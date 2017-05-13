package com.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.PageBean;
import com.entity.Role;
import com.entity.Tree;
import com.service.IRoleService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/role")
public class RoleController {
	@Autowired
	private IRoleService roleService;

	@RequestMapping("/roleManage")
	public String roleManage() {
		return "roleManage";
	}

	@RequestMapping(value="/getAllRole",method=RequestMethod.POST)
	@ResponseBody
	public String getAllRole(HttpServletRequest request) {
		String pageSize = request.getParameter("rows");
		String pageNum = request.getParameter("page");
		PageBean pageBean = new PageBean();
		pageBean.setPagein(Integer.valueOf(pageNum), Integer.valueOf(pageSize));
		List<Role> list = roleService.getAllRole(pageBean);
		int rowcount = roleService.getRoleCount(pageBean);
		JSONObject jsonObj = new JSONObject();
		jsonObj.accumulate("total", rowcount);
		jsonObj.accumulate("rows", list);
		return jsonObj.toString();
	}

	@RequestMapping(value="/saveOrUpdate",method=RequestMethod.POST)
	@ResponseBody
	public String saveOrUpdate(HttpServletRequest request) {
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		Role role = new Role();
		role.setId(id);
		role.setName(name);
		int n = roleService.saveOrUpdateRole(role);
		return String.valueOf(n);
	}

	@RequestMapping(value="/deleteRole",method=RequestMethod.POST)
	@ResponseBody
	public String deleteRole(String id) {
		int n = roleService.deleteRole(id);
		return String.valueOf(n);
	}

	@RequestMapping(value="/getMenuAuthTree",method=RequestMethod.POST)
	@ResponseBody
	public String getMenuAuthTree(String roleId) {
		List<Tree> list = roleService.getMenuAuthTree(roleId);
		JSONArray json = JSONArray.fromObject(list);
		return json.toString();

	}
	@RequestMapping(value="/updateRoleMenu",method=RequestMethod.POST)
	@ResponseBody
	public String updateRoleMenu(HttpServletRequest request) {
		String menuId = request.getParameter("menuId");
		String roleId = request.getParameter("roleId");
		int n = roleService.updateRoleMenu(menuId, roleId);
		return n>0?"true":"false";
	}
}
