package com.sist.web.model;

import java.io.Serializable;

public class KakaoPayAmount implements Serializable{
	private static final long serialVersionUID = -4462672593124452882L;
	
	private int total = 0; // 전체 결제 금액
	  private int tax_free = 0; // 비과세 금액
	  private int vat = 0; // 부가세 금액
	  private int point = 0; // 사용한 포인트 금액
	  private int discount = 0; // 할인 금액
	  private int green_deposit = 0; // 컵 보증금
	  
	  public KakaoPayAmount() {
	        
	  }

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getTax_free() {
		return tax_free;
	}

	public void setTax_free(int tax_free) {
		this.tax_free = tax_free;
	}

	public int getVat() {
		return vat;
	}

	public void setVat(int vat) {
		this.vat = vat;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		this.discount = discount;
	}

	public int getGreen_deposit() {
		return green_deposit;
	}

	public void setGreen_deposit(int green_deposit) {
		this.green_deposit = green_deposit;
	}
}
