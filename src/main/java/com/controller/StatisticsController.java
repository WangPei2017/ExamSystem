package com.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.StatisticsStudent;
import com.service.IStatisticsStudentService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/statistics")
public class StatisticsController {
	
	@Autowired
	IStatisticsStudentService statisticsStudentService;
	
	@RequestMapping("/statisticsLevel")
	public String statisticsLevel(){
		return "statisticsLevel";
	}
	
	@RequestMapping("/statisticsProvince")
	public String statisticsProvince(){
		return "statisticsProvince";
	}
	
	@RequestMapping("/statisticsStatus")
	public String statisticsStatus(){
		return "statisticsStatus";
	}
	
	@RequestMapping(value="/statisticsByLevel",method=RequestMethod.POST)
	@ResponseBody
	public String statisticsByLevel(HttpServletRequest request) {
		//报考级别统计
		List<StatisticsStudent> list = statisticsStudentService.statisticsByLevel();
		//放到分页组件中
		JSONObject jsonObj = new JSONObject();
		jsonObj.accumulate("rows", list);
		return jsonObj.toString();
	}
	
	@RequestMapping(value="/statisticsByProvince",method=RequestMethod.POST)
	@ResponseBody
	public String statisticsByProvince(HttpServletRequest request) {
		//省份统计
		List<StatisticsStudent> list = statisticsStudentService.statisticsByProvince();
		JSONObject jsonObj = new JSONObject();
		jsonObj.accumulate("rows", list);
		return jsonObj.toString();
	}
	
	@RequestMapping(value="/statisticsByStatus",method=RequestMethod.POST)
	@ResponseBody
	public String statisticsByStatus(HttpServletRequest request) {
		//报考级别统计
		List<StatisticsStudent> list = statisticsStudentService.statisticsByStatus();
		JSONObject jsonObj = new JSONObject();
		jsonObj.accumulate("rows", list);
		return jsonObj.toString();
	}

}
