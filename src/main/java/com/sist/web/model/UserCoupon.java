package com.sist.web.model;

import java.io.Serializable;

public class UserCoupon implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -39678771453271624L;
	
	private	String userCouponId;
	private	String userId;
	private	String couponId;
	private	String userCouponName;
	private	String userCouponIssueday;
	private	String userCouponUse;
	private	String userCouponUseday;
	private String userCouponExpiredate;
	
	public UserCoupon()
	{
		this.userCouponId = "";
		this.userId = "";
		this.couponId = "";
		this.userCouponName = "";
		this.userCouponIssueday = "";
		this.userCouponUse = "";
		this.userCouponUseday = "";
		this.userCouponExpiredate = "";
	}

	public String getUserCouponId() {
		return userCouponId;
	}

	public void setUserCouponId(String userCouponId) {
		this.userCouponId = userCouponId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCouponId() {
		return couponId;
	}

	public void setCouponId(String couponId) {
		this.couponId = couponId;
	}

	public String getUserCouponName() {
		return userCouponName;
	}

	public void setUserCouponName(String userCouponName) {
		this.userCouponName = userCouponName;
	}

	public String getUserCouponIssueday() {
		return userCouponIssueday;
	}

	public void setUserCouponIssueday(String userCouponIssueday) {
		this.userCouponIssueday = userCouponIssueday;
	}

	public String getUserCouponUse() {
		return userCouponUse;
	}

	public void setUserCouponUse(String userCouponUse) {
		this.userCouponUse = userCouponUse;
	}

	public String getUserCouponUseday() {
		return userCouponUseday;
	}

	public void setUserCouponUseday(String userCouponUseday) {
		this.userCouponUseday = userCouponUseday;
	}

	public String getUserCouponExpiredate() {
		return userCouponExpiredate;
	}

	public void setUserCouponExpiredate(String userCouponExpiredate) {
		this.userCouponExpiredate = userCouponExpiredate;
	}

	
	
	
}