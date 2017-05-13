package com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.PageBean;
import com.entity.Role;
import com.entity.SysUser;
import com.service.IRoleService;
import com.service.ISysUserService;
import com.util.JsonUtil;

import net.sf.json.JSONObject;
//考务管理
@Controller
@RequestMapping(value = "/user")
public class SysUserController {
	@Autowired
	private ISysUserService userService;
	@Autowired
	private IRoleService roleService;

	@RequestMapping("/userManage")
	public String userMarmanage() {
		return "userManage";
	}
	/**
	 * 分页注意事项:
	 * 1、easyui默认会传入分页参数  page表示第几页  rows：每页记录数
	 * 2、返回数据的时候，必须设置total总记录数，rows：数据集合
	 * 3、需要满足json格式
	 * @author fdz
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/getAllUser",method=RequestMethod.POST)
	@ResponseBody
	public String getAllUser(HttpServletRequest request) {
				//查询参数
				String name=request.getParameter("sname");
				//分页第几页
				String pageNumber=request.getParameter("page");
				//每页记录数
				String pageSize=request.getParameter("rows");
				
				PageBean pagebean=new PageBean();
				//分页统一设置
				pagebean.setPagein(Integer.parseInt(pageNumber),Integer.parseInt(pageSize));
				
				Map<String,Object> map=new HashMap<String,Object>();
				map.put("name", name);
				pagebean.setMap(map);
				//查询用户记录
				List<SysUser> list=userService.getAllUser(pagebean);
				//查询总记录数
				int rowcount=userService.getUserCount(pagebean);
				//放到分页组件中
				JSONObject jsonobj=new JSONObject();
				jsonobj.accumulate("total", rowcount);
				jsonobj.accumulate("rows", list);
				return jsonobj.toString();
	}

	@RequestMapping(value="/deleteUser",method=RequestMethod.POST)
	@ResponseBody
	public String deleteUser(String id) {
		int n = userService.deleteUser(id);
		return String.valueOf(n);
	}

	@RequestMapping(value="/saveOrUpdateUser",method=RequestMethod.POST)
	@ResponseBody
	public String saveOrUpdateUser(SysUser user) {
		int n = userService.saveOrUpdateUser(user);
		return String.valueOf(n);
	}

	@RequestMapping(value="/getUserById",method=RequestMethod.POST)
	@ResponseBody
	public String getUserById(String id) {
		SysUser user = userService.getUserById(id);
		JSONObject jsonObj = JsonUtil.bean2Json(user);
		return jsonObj.toString();
	}

	@RequestMapping(value="/getRoleList",method=RequestMethod.POST)
	@ResponseBody
	public String getRoleList(String id) {
		List<Role> list = roleService.getAllRole(null);
		String roleid = roleService.getRoleIdByUserId(id);
		JSONObject jsonObj = new JSONObject();
		jsonObj.accumulate("rolelist", list);
		jsonObj.accumulate("roleId", roleid);
		return jsonObj.toString();

	}

	@RequestMapping(value="/saveUserRole",method=RequestMethod.POST)
	@ResponseBody
	public String saveUserRole(String userId, String roleId) {
		int n = userService.saveUserRole(userId, roleId);
		return n>0?"true":"false";
	}
}
