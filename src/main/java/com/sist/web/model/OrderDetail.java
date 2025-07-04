package com.sist.web.model;

import java.io.Serializable;
import java.sql.Date;

public class OrderDetail implements Serializable {

    private static final long serialVersionUID = 1L;

    private String orderDetailsId;               // 상세 주문 ID (PK)
    private String accommRoomId;                  // 객실 ID (FK)
    private String orderId;                      // 주문 ID (FK)
    private int orderDetailsRoomEachPrice;       // 객실 개별 가격
    private int orderDetailsPeopleCount;         // 인원 수
    private String orderDetailsPaymentMethod;    // 결제 수단 (ex. KAKAOPAY)
    private int orderDetailsCount;               // 객실 수량
    private Date orderDetailsCheckinDate;        // 체크인 날짜
    private Date orderDetailsCheckoutDate;       // 체크아웃 날짜

    public OrderDetail() {
        this.orderDetailsId = "";
        this.accommRoomId = "";
        this.orderId = "";
        this.orderDetailsRoomEachPrice = 0;
        this.orderDetailsPeopleCount = 0;
        this.orderDetailsPaymentMethod = "KAKAOPAY";
        this.orderDetailsCount = 1;
        this.orderDetailsCheckinDate = new Date(System.currentTimeMillis());
        this.orderDetailsCheckoutDate = new Date(System.currentTimeMillis());
    }

    // --- Getter / Setter ---
    public String getOrderDetailsId() {
        return orderDetailsId;
    }

    public void setOrderDetailsId(String orderDetailsId) {
        this.orderDetailsId = orderDetailsId;
    }

    public String getAccommRoomId() {
        return accommRoomId;
    }

    public void setAccommRoomId(String accomRoomId) {
        this.accommRoomId = accomRoomId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public int getOrderDetailsRoomEachPrice() {
        return orderDetailsRoomEachPrice;
    }

    public void setOrderDetailsRoomEachPrice(int orderDetailsRoomEachPrice) {
        this.orderDetailsRoomEachPrice = orderDetailsRoomEachPrice;
    }

    public int getOrderDetailsPeopleCount() {
        return orderDetailsPeopleCount;
    }

    public void setOrderDetailsPeopleCount(int orderDetailsPeopleCount) {
        this.orderDetailsPeopleCount = orderDetailsPeopleCount;
    }

    public String getOrderDetailsPaymentMethod() {
        return orderDetailsPaymentMethod;
    }

    public void setOrderDetailsPaymentMethod(String orderDetailsPaymentMethod) {
        this.orderDetailsPaymentMethod = orderDetailsPaymentMethod;
    }

    public int getOrderDetailsCount() {
        return orderDetailsCount;
    }

    public void setOrderDetailsCount(int orderDetailsCount) {
        this.orderDetailsCount = orderDetailsCount;
    }

    public Date getOrderDetailsCheckinDate() {
        return orderDetailsCheckinDate;
    }

    public void setOrderDetailsCheckinDate(Date orderDetailsCheckinDate) {
        this.orderDetailsCheckinDate = orderDetailsCheckinDate;
    }

    public Date getOrderDetailsCheckoutDate() {
        return orderDetailsCheckoutDate;
    }

    public void setOrderDetailsCheckoutDate(Date orderDetailsCheckoutDate) {
        this.orderDetailsCheckoutDate = orderDetailsCheckoutDate;
    }
}
