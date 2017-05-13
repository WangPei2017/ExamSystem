package com.dao;

import java.util.List;

import com.entity.PageBean;
import com.entity.Student;

public interface ISystemMapper {
//注册
	Integer addStudent(Student student);

	Integer deleteStudent(String sid);

	Integer modifyStudent(Student student);

	Student findStudentById(Student student);

	List<Student> getAllStudent(PageBean pageBean);
	
	Student getStudentInfo(Student studentu);

	Integer getStudentCount(PageBean pageBean);
}