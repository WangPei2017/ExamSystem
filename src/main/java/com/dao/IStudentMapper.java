package com.dao;

import java.util.List;

import com.entity.PageBean;
import com.entity.Student;

public interface IStudentMapper {
//注册
	Integer addStudent(Student student);

	Integer deleteStudent(String sid);

	Integer modifyStudent(Student student);

	Student findStudentById(Student student);

	List<Student> getAllStudent(PageBean pageBean);
	
	Student getStudentInfo(Student studentu);

	Integer getStudentCount(PageBean pageBean);

	Integer countIdNumber(String idNumber);

	Integer countStudentById(String sid);

	Integer toAudit(Student student);

	Integer upateStudent(Student student);

}