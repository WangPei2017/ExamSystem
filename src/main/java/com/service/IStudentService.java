package com.service;

import java.util.List;

import com.entity.PageBean;
import com.entity.Student;

public interface IStudentService {
	
	Integer addStudent(Student student);
	
	Integer deleteStudent(String sid);
	
	Integer modifyStudent(Student student);
	
	Student findStudentById(Student student);
	
	List<Student> getAllStudent(PageBean pageBean);

	Student getStudentInfo(Student student);

	Integer getStudentCount(PageBean pageBean);

	Integer countIdNumber(String idNumber);

	Integer countStudentById(String sid);

	Student findStudentById(String sid);

	Integer toAudit(Student student);

	Integer upateStudent(Student student);

}
