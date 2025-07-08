package com.sist.web.model;

import java.io.Serializable;

public class Coupon implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 5209279590418634269L;
	private String couponId;          // 쿠폰 ID
    private String couponName;        // 쿠폰 이름
    private String couponType;        // 쿠폰 타입 (e.g., PERCENT, AMOUNT)
    private int couponAmount;         // 할인 금액 또는 비율
    private String couponCreatedate;  // 생성일 (문자열)
    private int couponExpiredate;   // 만료일 계산 기준 (며칠)
    private String couponPlace;       // 사용처 (예: ACCOMM, TOUR 등)
    private int couponCount;          // 총 수량!
    private int couponMaxAmount; //최대 할인 금액(추가)
    
    public Coupon() 
    {
        this.couponId = "";
        this.couponName = "";
        this.couponType = "";
        this.couponAmount = 0;
        this.couponCreatedate = "";
        this.couponExpiredate = 0; // DB에서 SYSDATE로 처리할 경우 null 허용
        this.couponPlace = "";
        this.couponCount = 0;
    }
    
    
    public int getCouponMaxAmount() {
		return couponMaxAmount;
	}


	public void setCouponMaxAmount(int couponMaxAmount) {
		this.couponMaxAmount = couponMaxAmount;
	}


	public String getCouponId() {
        return couponId;
    }

    public void setCouponId(String couponId) {
        this.couponId = couponId;
    }

    public String getCouponName() {
        return couponName;
    }

    public void setCouponName(String couponName) {
        this.couponName = couponName;
    }

    public String getCouponType() {
        return couponType;
    }

    public void setCouponType(String couponType) {
        this.couponType = couponType;
    }

    public int getCouponAmount() {
        return couponAmount;
    }

    public void setCouponAmount(int couponAmount) {
        this.couponAmount = couponAmount;
    }

    public String getCouponCreatedate() {
        return couponCreatedate;
    }

    public void setCouponCreatedate(String couponCreatedate) {
        this.couponCreatedate = couponCreatedate;
    }

    public int getCouponExpiredate() {
        return couponExpiredate;
    }

    public void setcouponExpiredate(int couponExpiredate) {
        this.couponExpiredate = couponExpiredate;
    }

    public String getCouponPlace() {
        return couponPlace;
    }

    public void setCouponPlace(String couponPlace) {
        this.couponPlace = couponPlace;
    }

    public int getCouponCount() {
        return couponCount;
    }

    public void setCouponCount(int couponCount) {
        this.couponCount = couponCount;
    }
} 
