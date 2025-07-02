package com.sist.web.model;

import java.io.Serializable;

public class Recommend implements Serializable {

	private static final long serialVersionUID = -2296508713073679524L;

	private String userId;
	private String planId;
	
	public Recommend()
	{
		userId = "";
		planId = "";
	}

	//getter-setter
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPlanId() {
		return planId;
	}

	public void setPlanId(String planId) {
		this.planId = planId;
	}
	
}
