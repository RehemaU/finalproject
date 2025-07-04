package com.sist.web.model;

import java.io.Serializable;

public class Payment implements Serializable {
	private static final long serialVersionUID = 5458792888916307235L;
	
	
	private int paymentId;
    private String userId;
    private String goodsId;
    private String goodsName;
    private int quantity;
    private int totalAmount;
    private String paymentMethod;
    private String paymentStatus;
    private String tid;
    private String regDate;
    
    public Payment() {
        this.paymentId = 0;
        this.userId = "";
        this.goodsId = "";
        this.goodsName = "";
        this.quantity = 0;
        this.totalAmount = 0;
        this.paymentMethod = "";
        this.paymentStatus = "";
        this.tid = "";
        this.regDate = "";
    }

	public int getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(int paymentId) {
		this.paymentId = paymentId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(int totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getPaymentStatus() {
		return paymentStatus;
	}

	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}	
    
}
