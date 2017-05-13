package com;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.entity.PageBean;
import com.entity.Student;
import com.service.IStudentService;

public class Test {
	public static void main(String[] args) {
		@SuppressWarnings("resource")
		ApplicationContext ctx=new ClassPathXmlApplicationContext("config/applicationContext.xml");
		IStudentService studentService = ctx.getBean(IStudentService.class);
		
Student student = new Student();
student.setSid("admin");
student.setPassword("admin");
student.setBirthday("1992-02-09");
student.setEmail("email");
student.setIdNumber("1234");
		PageBean pagebean = new PageBean();
		//分页统一设置
		pagebean.setPagein(Integer.parseInt("1"),Integer.parseInt("50"));
		
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("name", "admin");
		pagebean.setMap(map);
		studentService.deleteStudent("admin");
		studentService.addStudent(student );
List<Student> list = studentService.getAllStudent(pagebean);
System.out.println(list);
		
		System.out.println(studentService.findStudentById(student));
		
//		studentService.modifyStudent(student);
		
//		System.out.println(studentService.getStudentInfo(student));
		
		Student student = new Student();
//		student.setSid("admin");
//		student.setPassword("admin");
//		System.out.println(studentService.getStudentInfo(student));
		PageBean pageBean=new PageBean();
		pageBean.setPagein(1,30);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", null);
		pageBean.setMap(map );
		List<Student> allStudent = studentService.getAllStudent(pageBean);
		System.out.println(studentService.getStudentCount(pageBean));
	}




