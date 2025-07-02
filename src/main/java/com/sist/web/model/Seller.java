package com.sist.web.model;

import java.io.Serializable;

public class Seller implements Serializable
{
	
	private static final long serialVersionUID = 87006420130740722L;
	
	private String sellerId;                 //판매자아이디
	private String sellerName;				 //판매자이름
	private String sellerNumber;			 //판매자전화번호
	private String sellerPassword;		     //비밀번호
	private String sellerBusiness;			 //상호명 
	private String sellerEmail;				 //이메일
	private String sellerStatus;		     //승인여부
	private String sellerRegdate;	         //가입날짜
	private String sellerSellnumber;		 //사업자등록번호
	
	
	public Seller()
	{
		sellerId="";
		sellerName="";	
		sellerNumber="";
	    sellerPassword="";	
		sellerBusiness="";	
		sellerEmail="";	
		sellerStatus="";		
		sellerRegdate="";	
		sellerSellnumber="";
	}


	public String getSellerId() {
		return sellerId;
	}


	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}


	public String getSellerName() {
		return sellerName;
	}


	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}


	public String getSellerNumber() {
		return sellerNumber;
	}


	public void setSellerNumber(String sellerNumber) {
		this.sellerNumber = sellerNumber;
	}


	public String getSellerPassword() {
		return sellerPassword;
	}


	public void setSellerPassword(String sellerPassword) {
		this.sellerPassword = sellerPassword;
	}


	public String getSellerBusiness() {
		return sellerBusiness;
	}


	public void setSellerBusiness(String sellerBusiness) {
		this.sellerBusiness = sellerBusiness;
	}


	public String getSellerEmail() {
		return sellerEmail;
	}


	public void setSellerEmail(String sellerEmail) {
		this.sellerEmail = sellerEmail;
	}


	public String getSellerStatus() {
		return sellerStatus;
	}


	public void setSellerStatus(String sellerStatus) {
		this.sellerStatus = sellerStatus;
	}


	public String getSellerRegdate() {
		return sellerRegdate;
	}


	public void setSellerRegdate(String sellerRegdate) {
		this.sellerRegdate = sellerRegdate;
	}


	public String getSellerSellnumber() {
		return sellerSellnumber;
	}


	public void setSellerSellnumber(String sellerSellnumber) {
		this.sellerSellnumber = sellerSellnumber;
	}
}
