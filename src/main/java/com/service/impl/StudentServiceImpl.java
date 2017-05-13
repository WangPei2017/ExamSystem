package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.IStudentMapper;
import com.entity.PageBean;
import com.entity.Student;
import com.service.IStudentService;
import com.util.MD5;

@Service
public class StudentServiceImpl implements IStudentService{
	@Autowired
	private IStudentMapper studentmapper;
	
	public void setStudentmapper(IStudentMapper studentmapper) {
		this.studentmapper = studentmapper;
	}

	public Integer addStudent(Student student) {
//		将密码进行加密
		String encPassword = MD5.encodeMD5(student.getSid(), student.getPassword());
//		将密码设置为密文
		student.setPassword(encPassword);
		return studentmapper.addStudent(student);
	}
	public Integer deleteStudent(String sid) {
		return studentmapper.deleteStudent(sid);
	}

	public Integer modifyStudent(Student student) {
		return studentmapper.modifyStudent(student);
		
	}

	public Student findStudentById(Student student) {
		return studentmapper.findStudentById(student);
	}

	public List<Student> getAllStudent(PageBean pageBean) {
		return studentmapper.getAllStudent(pageBean);
	}

	public Student getStudentInfo(Student student) {
		return studentmapper.getStudentInfo(student);
	}

	public Integer getStudentCount(PageBean pageBean) {
		return studentmapper.getStudentCount(pageBean);
	}

	public Integer countIdNumber(String idNumber) {
		return studentmapper.countIdNumber(idNumber);
	}

	public Integer countStudentById(String sid) {
		return studentmapper.countStudentById(sid);
	}

	public Student findStudentById(String sid) {
		Student student = new Student();
		student.setSid(sid);
		return studentmapper.findStudentById(student);
	}

	public Integer toAudit(Student student) {
		
		return studentmapper.toAudit(student);
	}

	public Integer upateStudent(Student student) {
		
		return studentmapper.upateStudent(student);
	}

}
