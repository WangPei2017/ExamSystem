package com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.Student;
import com.service.IStudentService;
//审核
@Controller
@RequestMapping(value = "/audit")
public class AuditController {
	@Autowired
	private IStudentService studentService;

	@RequestMapping("/auditManage")
	public String auditManage() {
		return "auditManage";
	}

	@RequestMapping(value="/toAudit",method=RequestMethod.POST)
	@ResponseBody
	public String toAudit(String sid, String status, String reason) {
		Student student = new Student();
		student.setSid(sid);
		student.setStatus(status);
		student.setReason(reason);
		int n = studentService.toAudit(student);
		return String.valueOf(n);
	}
	
}
