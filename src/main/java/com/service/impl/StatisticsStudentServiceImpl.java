package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.IStatisticsStudentMapper;
import com.entity.StatisticsStudent;
import com.service.IStatisticsStudentService;
@Service
public class StatisticsStudentServiceImpl implements IStatisticsStudentService {
	@Autowired
	private IStatisticsStudentMapper statisticsMapper;

	public List<StatisticsStudent> statisticsByLevel() {
		
		return statisticsMapper.statisticsByLevel();
	}

	public List<StatisticsStudent> statisticsByProvince() {
		
		return statisticsMapper.statisticsByProvince();
	}

	public List<StatisticsStudent> statisticsByStatus() {
		
		return statisticsMapper.statisticsByStatus();
	}

}
