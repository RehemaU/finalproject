package com.sist.web.dao;

import java.util.List;
import java.util.Map;

import com.sist.web.model.Order;
import com.sist.web.model.OrderDetail;

public interface OrderDao {
    
    // 주문 삽입
    void insertOrder(Order order);
    
    // 주문 상세 삽입
    void insertOrderDetail(OrderDetail orderDetail);

    // 단건 주문 조회
    Order selectOrderById(String orderId);

    // 해당 주문의 상세 목록 조회
    List<OrderDetail> selectOrderDetailsByOrderId(String orderId);
    
    // 주문의 refund 여부 업데이트
    void updateOrderRefund(Map<String, Object> param);
    
    // 주문상태(결제시) 업데이트
    void updateOrderStatus(Map<String, Object> param);
    
    // 자동삭제 스케줄러 관련
    List<String> selectExpiredOrderIds(Map<String, Object> param);
    void deleteOrderById(String orderId);
    void deleteOrderDetailsByOrderId(String orderId);
}
