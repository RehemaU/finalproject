package com.sist.web.model;

import java.io.Serializable;

public class Pcomment implements Serializable {

	private static final long serialVersionUID = -4772499186845107077L;

	private String commentId;
	private String planId;
	private String userId;
	private String planCommentContent;
	private int planCommentParent;
	private String planCommentDate;
	private int planCommentReport;
	
	private String userName;
	private String planTitle;
	
	public Pcomment()
	{
		commentId = "";
		planId = "";
		userId = "";
		planCommentContent = "";
		planCommentParent = 0;
		planCommentDate = "";
		planCommentReport = 0;
		
		userName = "";
		planTitle = "";
	}

	//getter-setter
	public String getCommentId() {
		return commentId;
	}

	public void setCommentId(String commentId) {
		this.commentId = commentId;
	}

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

	public String getPlanCommentContent() {
		return planCommentContent;
	}

	public void setPlanCommentContent(String planCommentContent) {
		this.planCommentContent = planCommentContent;
	}

	public int getPlanCommentParent() {
		return planCommentParent;
	}

	public void setPlanCommentParent(int planCommentParent) {
		this.planCommentParent = planCommentParent;
	}

	public String getPlanCommentDate() {
		return planCommentDate;
	}

	public void setPlanCommentDate(String planCommentDate) {
		this.planCommentDate = planCommentDate;
	}

	public int getPlanCommentReport() {
		return planCommentReport;
	}

	public void setPlanCommentReport(int planCommentReport) {
		this.planCommentReport = planCommentReport;
	}
	
	public String getUserName() {
		return userName;
	}
	
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getPlanTitle() {
		return planTitle;
	}
	
	public void setPlanTitle(String planTitle) {
		this.planTitle = planTitle;
	}
	
}

