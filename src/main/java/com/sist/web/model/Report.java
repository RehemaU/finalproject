package com.sist.web.model;

import java.io.Serializable;

public class Report implements Serializable {

	private static final long serialVersionUID = -149975738971438632L;

	private String planId;
	private String userId;
	private int reportReason;
	
	public Report()
	{
		planId = "";
		userId = "";
		reportReason = 0;
	}

	//getter-setter
	public String getPlanId() {
		return planId;
	}

	public void setPlanId(String planId) {
		this.planId = planId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getReportReason() {
		return reportReason;
	}

	public void setReportReason(int reportReason) {
		this.reportReason = reportReason;
	}

}
