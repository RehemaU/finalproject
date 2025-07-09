package com.sist.web.model;

import java.io.Serializable;

public class Refund implements Serializable {

    private static final long serialVersionUID = 1L;

    private String refundId;       // 환불 ID
    private String userId;         // 환불 요청자 ID
    private String refundCause;    // 환불 사유
    private String orderId;        // 주문 ID
    private String refundResult;   // 환불 결과 (REQUESTED, SUCCESS, FAILED 등)

    public Refund() {
        this.refundId = "";
        this.userId = "";
        this.refundCause = "";
        this.orderId = "";
        this.refundResult = "REQUESTED"; // 기본값
    }

    public String getRefundId() {
        return refundId;
    }

    public void setRefundId(String refundId) {
        this.refundId = refundId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getRefundCause() {
        return refundCause;
    }

    public void setRefundCause(String refundCause) {
        this.refundCause = refundCause;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getRefundResult() {
        return refundResult;
    }

    public void setRefundResult(String refundResult) {
        this.refundResult = refundResult;
    }
}
