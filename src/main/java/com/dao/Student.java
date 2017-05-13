package com.dao;

import java.io.Serializable;

public class Student implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -759950498402323129L;
	private String sid;//学生用户名
	private String password;//学生登录密码
	private String sname;//学生姓名
	private String idNumber;//身份证号码
	private String birthday;//出生日期
	private String level;//报考级别1:一级、2:二级、3:三级、4:四级
	private String sex;//性别"1"?"男":"女"
	private Integer phone;//手机号
	private String email;//邮箱
	private String province;//报考省份
	private String photo;//上传照片格式为jpg
	private String status;//审核状态 0:未提交，1：待审核 ，2：审核通过:3审核未通过
	private String reason;//审核未通过原因
	private	Integer levelcount;//报考级别统计
	private	Integer provincecount;//省份统计
	private	Integer statuscount;//审核状态统计
	public Student() {
		super();
	}
	
	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSname() {
		return sname;
	}

	public void setSname(String sname) {
		this.sname = sname;
	}

	public String getIdNumber() {
		return idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public Integer getPhone() {
		return phone;
	}

	public void setPhone(Integer phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
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
		return "Student [sid=" + sid + ", password=" + password + ", sname=" + sname + ", idNumber=" + idNumber
				+ ", birthday=" + birthday + ", level=" + level + ", sex=" + sex + ", phone=" + phone + ", email="
				+ email + ", province=" + province + ", photo=" + photo + ", status=" + status + ", reason=" + reason
				+ "]";
	}
	
}
