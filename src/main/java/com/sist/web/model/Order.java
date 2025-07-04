package com.sist.web.model;

import java.io.Serializable;
import java.sql.Date;

public class Order implements Serializable {

    private static final long serialVersionUID = 1L;

    private String orderId;           // 주문 ID (PK)
    private String userId;            // 사용자 ID (FK)
    private String refundId;          // 환불 ID (nullable)
    private int orderTotalAmount;     // 총 결제 금액
    private Date orderDate;           // 주문 일시
    private String orderStatus;       // 주문 상태 ('Y', 'N', etc.)
    private int orderExpendPoint;     // 사용한 포인트
    private String orderCouponId;     // 사용한 쿠폰 ID

    public Order() {
        this.orderId = "";
        this.userId = "";
        this.refundId = "";
        this.orderTotalAmount = 0;
        this.orderDate = new Date(System.currentTimeMillis());
        this.orderStatus = "Y";
        this.orderExpendPoint = 0;
        this.orderCouponId = "";
    }

    // --- Getter / Setter ---
    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getRefundId() {
        return refundId;
    }

    public void setRefundId(String refundId) {
        this.refundId = refundId;
    }

    public int getOrderTotalAmount() {
        return orderTotalAmount;
    }

    public void setOrderTotalAmount(int orderTotalAmount) {
        this.orderTotalAmount = orderTotalAmount;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public int getOrderExpendPoint() {
        return orderExpendPoint;
    }

    public void setOrderExpendPoint(int orderExpendPoint) {
        this.orderExpendPoint = orderExpendPoint;
    }

    public String getOrderCouponId() {
        return orderCouponId;
    }

    public void setOrderCouponId(String orderCouponId) {
        this.orderCouponId = orderCouponId;
    }
}
