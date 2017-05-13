package com.entity;

import java.io.Serializable;
//考务
public class SysUser implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -1535708805278635640L;
	private String id;
	private String name;
	private String password;
	private String enable;
	public String getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEnable() {
		return enable;
	}
	public void setEnable(String enable) {
		this.enable = enable;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", password=" + password + ", enable=" + enable + "]";
	}
	
	
}
