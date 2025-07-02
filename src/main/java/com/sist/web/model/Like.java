package com.sist.web.model;

import java.io.Serializable;

public class Like implements Serializable{
	
	private static final long serialVersionUID = 6338014171269162979L;

	private String likeId;
	private String userId;
	private String spotId;
	
	public Like()
	{
		likeId = "";
		userId = "";
		spotId = "";
	}
	public Like(String likeId, String userId, String spotId)
	{
		this.likeId = "";
		this.spotId = "";
		this.userId = "";
	}
	public String getLikeId() {
		return likeId;
	}

	public void setLikeId(String likeId) {
		this.likeId = likeId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getSpotId() {
		return spotId;
	}

	public void setSpotId(String spotId) {
		this.spotId = spotId;
	}
	
	
}
