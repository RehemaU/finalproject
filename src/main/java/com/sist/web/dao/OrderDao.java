package com.sist.web.dao;

import java.util.List;

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
}
