package com.service;

import java.util.List;

import com.entity.StatisticsStudent;

public interface IStatisticsStudentService {

	List<StatisticsStudent> statisticsByLevel();

	List<StatisticsStudent> statisticsByProvince();
	
	List<StatisticsStudent> statisticsByStatus();
}
