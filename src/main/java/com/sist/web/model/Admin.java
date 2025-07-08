package com.sist.web.model;

import java.io.Serializable;

public class Admin implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8539509599376816969L;

	
	private String adminId;
	private String adminPassword;
	private String adminName;
	
	
	
	public Admin() 
	{
		this.adminId = "";
		this.adminPassword = "";
		this.adminName = "";
		
		
		
	}



	public String getAdminId() {
		return adminId;
	}



	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}



	public String getAdminPassword() {
		return adminPassword;
	}



	public void setAdminPassword(String adminPassword) {
		this.adminPassword = adminPassword;
	}



	public String getAdminName() {
		return adminName;
	}



	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	
	
	
	
}
