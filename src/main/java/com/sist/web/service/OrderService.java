package com.sist.web.service;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sist.web.dao.AccommodationRoomDao;
import com.sist.web.dao.CouponDao;
import com.sist.web.dao.OrderDao;
import com.sist.web.dao.UserCouponDao;
import com.sist.web.model.Order;
import com.sist.web.model.OrderDetail;
import com.sist.web.model.UserCoupon;

@Service
public class OrderService {

    @Autowired
    private OrderDao orderDao;
    
    @Autowired
    private AccommodationRoomDao accommodationRoomDao;
    
    @Autowired
    private UserCouponDao userCouponDao;
    
    // 단건 주문 등록
    public void createOrder(String userId, String roomId, LocalDate checkIn, LocalDate checkOut,
                            int totalAmount, String couponId, String paymentMethod) {

        String orderId = UUID.randomUUID().toString(); // ORDER_ID 생성
        String orderDetailId = UUID.randomUUID().toString(); // 상세 ID도 생성

        // 👉 주문 정보 생성
        Order order = new Order();
        order.setOrderId(orderId);
        order.setUserId(userId);
        order.setOrderTotalAmount(totalAmount);
        order.setOrderStatus("1"); // 예: 1 = 결제완료
        order.setOrderDate(java.sql.Date.valueOf(LocalDate.now()));
        order.setOrderCouponId(couponId); // null 허용

        orderDao.insertOrder(order);

        // 👉 상세 주문 정보 생성
        OrderDetail detail = new OrderDetail();
        detail.setOrderDetailsId(orderDetailId);
        detail.setOrderId(orderId);
        detail.setAccommRoomId(roomId);
        detail.setOrderDetailsCheckinDate(java.sql.Date.valueOf(checkIn));
        detail.setOrderDetailsCheckoutDate(java.sql.Date.valueOf(checkOut));
        detail.setOrderDetailsRoomEachPrice(totalAmount);
        detail.setOrderDetailsCount(1); // 기본 1건
        detail.setOrderDetailsPaymentMethod(paymentMethod);
        detail.setOrderDetailsPeopleCount(2); // 기본값, 또는 인자로 받을 수 있음

        orderDao.insertOrderDetail(detail);
    }
    
    @Transactional
    public boolean insertOrder(Order order, OrderDetail detail, String checkIn, String checkOut) {
        Map<String, Object> param = new HashMap<>();
        param.put("roomId", detail.getAccommRoomId());
        param.put("checkIn", checkIn);
        param.put("checkOut", checkOut);

        int overbookedDays = accommodationRoomDao.isRoomOverbooked(param);
        if (overbookedDays > 0) {
            return false; // 이미 예약 불가한 날짜가 있음
        }

        orderDao.insertOrder(order);
        orderDao.insertOrderDetail(detail);

        if (order.getOrderCouponId() != null) {
            userCouponDao.updateUserCouponUse(order.getOrderCouponId());
        }

        return true;
    }
    
    @Autowired
    private AccommodationRoomPriceService accommodationRoomPriceService;

    @Autowired
    private UserCouponService userCouponService;

    public int calculateTotalPrice(String roomId, String checkInStr, String checkOutStr, String couponId) {
        int basePrice = (int) accommodationRoomPriceService.calculateTotalPrice(roomId, checkInStr, checkOutStr).getTotalPrice();
        int discount = 0;

        if (couponId != null && !couponId.isEmpty()) {
            UserCoupon coupon = userCouponService.getUserCouponById(couponId);
            if (coupon != null) {
                if ("P".equals(coupon.getCouponType())) {
                    discount = (int) (basePrice * (coupon.getCouponAmount() / 100.0));
                    if (coupon.getCouponMaxAmount() > 0 && discount > coupon.getCouponMaxAmount()) {
                        discount = coupon.getCouponMaxAmount();
                    }
                } else if ("A".equals(coupon.getCouponType())) {
                    discount = coupon.getCouponAmount();
                }
            }
        }

        return Math.max(basePrice - discount, 0);
    }

}
