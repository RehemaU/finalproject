package com.sist.web.model;

import java.io.Serializable;

public class Review implements Serializable {

	private static final long serialVersionUID = -7696173612932529706L;

	private String accommReviewId;
	private String userId;
	private String accommId;
	private String accommReviewContent;
	private int accommReviewRating;
	
	public Review()
	{
		accommReviewId = "";
		userId = "";
		accommId = "";
		accommReviewContent = "";
		accommReviewRating = 0;
	}

	//getter-setter
	public String getAccommReviewId() {
		return accommReviewId;
	}

	public void setAccommReviewId(String accommReviewId) {
		this.accommReviewId = accommReviewId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getAccommId() {
		return accommId;
	}

	public void setAccommId(String accommId) {
		this.accommId = accommId;
	}

	public String getAccommReviewContent() {
		return accommReviewContent;
	}

	public void setAccommReviewContent(String accommReviewContent) {
		this.accommReviewContent = accommReviewContent;
	}

	public int getAccommReviewRating() {
		return accommReviewRating;
	}

	public void setAccommReviewRating(int accommReviewRating) {
		this.accommReviewRating = accommReviewRating;
	}

}
