package com.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.SysUser;
import com.service.ISystemLoginService;
import com.util.MD5;

@Controller
@RequestMapping(value="/system")
public class SystemLogController {

	@Autowired
	private ISystemLoginService systemLoginService;
	
	@RequestMapping("/systologin")
	public String systologin(){
		return "syslogin";
	}
	@RequestMapping("/main")
	public String main(){
		return "main";
	}
	/**
	 * 接收前端参数方法
	 * 1、如果是表单或者是ajax传递过来的参数，可以直接把表单的参数写在Controller相应的方法的形参中
	 * 2、用对象可以直接接收参数，前提是对象的属性字段与表单传递的参数name所属一致
	 * 3、通过HttpServletRequest接收，将HttpServletRequest写在Controller相应的方法中
	 * 4、通过注解参数方法接收参数 @RequestParam("sid") String a
	 */
	@RequestMapping(value="/sysdologin",method=RequestMethod.POST)
	@ResponseBody
	public String sysdologin(String username,String password,HttpSession session){
		String mess="";
		SysUser user=new SysUser();
		user.setName(username);
//		将密码进行加密
		String encPassword = MD5.encodeMD5(username, password);
//		将密码设置为密文
		user.setPassword(encPassword);
		SysUser ufid = systemLoginService.getUserInfo(user);
		if(ufid!=null && ufid.getName()!=null){
			//则说明用户存在，跳转到主页面,同时将用户信息放到session中
			session.setAttribute("userinfo", ufid);
			mess="ok";
		}else{
			mess="用户名或者密码错误";
		}
		return mess;
	}
	@RequestMapping("/syslogout")
	public String logout(HttpServletRequest request){
		request.getSession().removeAttribute("stuinfo");
		return "syslogin";
	}
}
