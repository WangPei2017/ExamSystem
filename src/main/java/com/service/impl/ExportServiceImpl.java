package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.IExportMapper;
import com.entity.Student;
import com.service.IExportService;

@Service
public class ExportServiceImpl implements IExportService {

	@Autowired
	private IExportMapper exportMapper;
	public List<Student> getStudentList() {
		return exportMapper.getStudentList();
	}

}
