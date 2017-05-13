package com.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.Student;
import com.service.IStudentService;
import com.util.MD5;

@Controller
@RequestMapping(value="/login")
public class StudentLoginController {

	@Autowired
	private IStudentService studentService;
	
	@RequestMapping("/tologin")
	public String tologin(){
		return "studentLogin";
	}
	/**
	 * 接收前端参数方法
	 * 1、如果是表单或者是ajax传递过来的参数，可以直接把表单的参数写在Controller相应的方法的形参中
	 * 2、用对象可以直接接收参数，前提是对象的属性字段与表单传递的参数name所属一致
	 * 3、通过HttpServletRequest接收，将HttpServletRequest写在Controller相应的方法中
	 * 4、通过注解参数方法接收参数 @RequestParam("sid") String a
	 */
	@RequestMapping(value="/dologin",method=RequestMethod.POST)
	@ResponseBody
	public String dologin(String sid,String password,HttpSession session){
		String mess="";
		Student stu=new Student();
		stu.setSid(sid);
//		将密码进行加密
		String encPassword = MD5.encodeMD5(sid, password);
//		将密码设置为密文
		stu.setPassword(encPassword);
		Student student = studentService.getStudentInfo(stu);
		if(student!=null && student.getSid()!=null){
			//则说明用户存在，跳转到主页面,同时将用户信息放到session中
			session.setAttribute("stuinfo", student);
			mess="ok";
		}else{
			mess="用户名或者密码错误";
		}
		return mess;
	}
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request){
		request.getSession().removeAttribute("stuinfo");
		return "login";
	}
}
