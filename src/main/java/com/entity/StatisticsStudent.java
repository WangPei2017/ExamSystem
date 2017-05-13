package com.entity;

import java.io.Serializable;

public class StatisticsStudent implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3698845991292120988L;
	private String level;//报考级别1:一级、2:二级、3:三级、4:四级
	private String province;//报考省份
	private String status;//审核状态 0:未提交，1：待审核 ，2：审核通过:3审核未通过
	private	Integer levelcount;//报考级别统计
	private	Integer provincecount;//省份统计
	private	Integer statuscount;//审核状态统计
	public StatisticsStudent() {
		super();
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Integer getLevelcount() {
		return levelcount;
	}
	public void setLevelcount(Integer levelcount) {
		this.levelcount = levelcount;
	}
	public Integer getProvincecount() {
		return provincecount;
	}
	public void setProvincecount(Integer provincecount) {
		this.provincecount = provincecount;
	}
	public Integer getStatuscount() {
		return statuscount;
	}
	public void setStatuscount(Integer statuscount) {
		this.statuscount = statuscount;
	}
	@Override
	public String toString() {
		return "StatisticsStudent [level=" + level + ", province=" + province + ", status=" + status + ", levelcount="
				+ levelcount + ", provincecount=" + provincecount + ", statuscount=" + statuscount + "]";
	}
	
	
	
}
