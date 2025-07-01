package com.sist.web.model;

import java.io.Serializable;

public class User implements Serializable 
{
	private static final long serialVersionUID = 2015965517661120001L;

	private String userId;	        //회원 아이디 (pk)
	private String userPassword;	//비밀번호
	private String userName;	    //이름
	private String userGender;	    //성별 (M/F)
	private String userNumber;	    //휴대전화 번호
	private String userAdd;	        //주소
	private String userBirth;	    //생년월일 (yyyymmdd)
	private String userEmail;	    //이메일
	private String userOut;	        //탈퇴 여부 (Y/N)
	private String userRegdate;	    //가입일자
	private String userProfile;	    //프로필 사진 경로
	
	public User()
	{
		userId="";	        
		userPassword="";	
		userName="";	    
		userGender="";	   
		userNumber="";	    
		userAdd="";	       
		userBirth="";	    
		userEmail="";	    
		userOut="";	        
		userRegdate="";	    
		userProfile="";	
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserGender() {
		return userGender;
	}

	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}

	public String getUserNumber() {
		return userNumber;
	}

	public void setUserNumber(String userNumber) {
		this.userNumber = userNumber;
	}

	public String getUserAdd() {
		return userAdd;
	}

	public void setUserAdd(String userAdd) {
		this.userAdd = userAdd;
	}

	public String getUserBirth() {
		return userBirth;
	}

	public void setUserBirth(String userBirth) {
		this.userBirth = userBirth;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserOut() {
		return userOut;
	}

	public void setUserOut(String userOut) {
		this.userOut = userOut;
	}

	public String getUserRegdate() {
		return userRegdate;
	}

	public void setUserRegdate(String userRegdate) {
		this.userRegdate = userRegdate;
	}

	public String getUserProfile() {
		return userProfile;
	}

	public void setUserProfile(String userProfile) {
		this.userProfile = userProfile;
	}
	
	
}
