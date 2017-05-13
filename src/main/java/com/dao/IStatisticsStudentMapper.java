package com.dao;

import java.util.List;

import com.entity.StatisticsStudent;

public interface IStatisticsStudentMapper {

	List<StatisticsStudent> statisticsByLevel();

	List<StatisticsStudent> statisticsByProvince();
	
	List<StatisticsStudent> statisticsByStatus();
}
