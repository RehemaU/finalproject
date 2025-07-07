package com.sist.web.controller;

import com.sist.common.util.StringUtil;
import com.sist.web.model.*;
import com.sist.web.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/order/kakao")
public class KakaoPayController {

    private static final Logger logger = LoggerFactory.getLogger(KakaoPayController.class);
    private static final String ORDER_STATUS_COMPLETE = "1";

    @Autowired private KakaoPayService kakaoPayService;
    @Autowired private AccommodationRoomService accommodationRoomService;
    @Autowired private AccommodationRoomPriceService accommodationRoomPriceService;
    @Autowired private UserCouponService couponService;
    @Autowired private OrderService orderService;

    @Value("#{env['kakaopay.tid.session.name']}")
    private String KAKAOPAY_TID_SESSION_NAME;

    @Value("#{env['kakaopay.orderid.session.name']}")
    private String KAKAOPAY_ORDERID_SESSION_NAME;

    @PostMapping("/start")
    @ResponseBody
    public Map<String, Object> kakaoPayStart(HttpServletRequest request, @RequestBody Map<String, String> param) {
        Map<String, Object> res = new HashMap<>();
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                res.put("status", -9);
                res.put("message", "세션이 유효하지 않습니다.");
                return res;
            }

            String userId = (String) session.getAttribute("userId");
            String roomId = param.get("roomId");
            String checkIn = param.get("checkIn");
            String checkOut = param.get("checkOut");
            String userCouponId = param.get("userCouponId");

            AccommodationRoom room = accommodationRoomService.searchByAccommRoomId(roomId);
            if (room == null) {
                res.put("status", -1);
                res.put("message", "객실 정보를 찾을 수 없습니다.");
                return res;
            }

            int basePrice = (int) accommodationRoomPriceService
                    .calculateTotalPrice(roomId, checkIn, checkOut)
                    .getTotalPrice();
            int discount = 0;

            if (userCouponId != null && !userCouponId.isEmpty()) {
                UserCoupon coupon = couponService.getUserCouponById(userCouponId);
                if (coupon != null && userId.trim().equals(coupon.getUserId().trim())) {
                    String type = coupon.getCouponType();
                    if ("P".equalsIgnoreCase(type) || "PERCENT".equalsIgnoreCase(type)) {
                        discount = (int) (basePrice * (coupon.getCouponAmount() / 100.0));
                        if (coupon.getCouponMaxAmount() > 0 && discount > coupon.getCouponMaxAmount()) {
                            discount = coupon.getCouponMaxAmount();
                        }
                    } else if ("A".equalsIgnoreCase(type) || "AMOUNT".equalsIgnoreCase(type)) {
                        discount = coupon.getCouponAmount();
                    }
                } else {
                    logger.warn("쿠폰 조회 실패 또는 사용자 불일치: couponId={}, userId={}", userCouponId, userId);
                }
            }

            int finalPrice = Math.max(basePrice - discount, 0);
            String orderId = UUID.randomUUID().toString();

            KakaoPayReadyRequest req = new KakaoPayReadyRequest();
            req.setPartner_order_id(orderId);
            req.setPartner_user_id(userId);
            req.setItem_name(room.getRoomName());
            req.setItem_code(roomId);
            req.setQuantity(1);
            req.setTotal_amount(finalPrice);
            req.setTax_free_amount(0);
            
            KakaoPayReadyResponse kakaoRes = kakaoPayService.ready(req);
            if (kakaoRes == null) {
                res.put("status", -1);
                res.put("message", "카카오페이 결제 준비 실패");
                return res;
            }

            // 세션 저장
            session.setAttribute("order_roomId", roomId);
            session.setAttribute("order_checkIn", checkIn);
            session.setAttribute("order_checkOut", checkOut);
            session.setAttribute("order_userCouponId", userCouponId);
            session.setAttribute("order_totalPrice", finalPrice);
            session.setAttribute(KAKAOPAY_TID_SESSION_NAME, kakaoRes.getTid());
            session.setAttribute(KAKAOPAY_ORDERID_SESSION_NAME, orderId);

            res.put("status", 0);
            res.put("nextRedirectPcUrl", kakaoRes.getNext_redirect_pc_url());
            return res;
        } catch (Exception e) {
            logger.error("[KakaoPayController] kakaoPayStart error", e);
            res.put("status", -99);
            res.put("message", "결제 요청 처리 중 오류가 발생했습니다.");
            return res;
        }
    }

    @GetMapping("/success")
    public String kakaoPaySuccess(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            model.addAttribute("code", -99);
            model.addAttribute("msg", "세션이 만료되었습니다.");
            return "/order/fail";
        }

        String userId = (String) session.getAttribute("userId");
        String pg_token = request.getParameter("pg_token");
        String tid = (String) session.getAttribute(KAKAOPAY_TID_SESSION_NAME);
        String orderId = (String) session.getAttribute(KAKAOPAY_ORDERID_SESSION_NAME);

        String roomId = (String) session.getAttribute("order_roomId");
        String checkIn = (String) session.getAttribute("order_checkIn");
        String checkOut = (String) session.getAttribute("order_checkOut");
        String userCouponId = (String) session.getAttribute("order_userCouponId");
        int finalPrice = (int) session.getAttribute("order_totalPrice");

        if (StringUtil.isEmpty(pg_token) || StringUtil.isEmpty(tid)) {
            model.addAttribute("code", -1);
            model.addAttribute("msg", "결제 승인 정보 누락");
            return "/order/fail";
        }

        KakaoPayApproveRequest approveReq = new KakaoPayApproveRequest();
        approveReq.setTid(tid);
        approveReq.setPartner_order_id(orderId);
        approveReq.setPartner_user_id(userId);
        approveReq.setPg_token(pg_token);

        KakaoPayApproveResponse approveRes = kakaoPayService.approve(approveReq);
        if (approveRes == null || approveRes.getError_code() != 0) {
            model.addAttribute("code", -2);
            model.addAttribute("msg", "카카오페이 승인 실패");
            return "/order/fail";
        }

        // 주문 및 상세 저장
        Order order = new Order();
        order.setOrderId(orderId);
        order.setUserId(userId);
        order.setOrderDate(Date.valueOf(LocalDate.now()));
        order.setOrderTotalAmount(finalPrice);
        order.setOrderStatus(ORDER_STATUS_COMPLETE);
        order.setOrderCouponId(userCouponId);

        OrderDetail detail = new OrderDetail();
        detail.setOrderDetailsId(UUID.randomUUID().toString());
        detail.setOrderId(orderId);
        detail.setAccommRoomId(roomId);
        detail.setOrderDetailsCheckinDate(Date.valueOf(checkIn));
        detail.setOrderDetailsCheckoutDate(Date.valueOf(checkOut));
        detail.setOrderDetailsRoomEachPrice(finalPrice);
        detail.setOrderDetailsPeopleCount(2); // 인원 수 추후 반영
        detail.setOrderDetailsPaymentMethod("KAKAOPAY");
        detail.setOrderDetailsCount(1);

        orderService.insertOrder(order, detail);

        if (userCouponId != null && !userCouponId.isEmpty()) {
            couponService.useCoupon(userCouponId);
        }
        else {
        	System.out.println("씨발");
        }
        session.setAttribute("complete_order", order);
        session.setAttribute("complete_detail", detail);

        // 세션 정리
        session.removeAttribute(KAKAOPAY_TID_SESSION_NAME);
        session.removeAttribute(KAKAOPAY_ORDERID_SESSION_NAME);
        session.removeAttribute("order_roomId");
        session.removeAttribute("order_checkIn");
        session.removeAttribute("order_checkOut");
        session.removeAttribute("order_userCouponId");
        session.removeAttribute("order_totalPrice");

        model.addAttribute("order", order);
        model.addAttribute("detail", detail);

        model.addAttribute("code", 0);
        model.addAttribute("msg", "결제가 완료되었습니다.");
        model.addAttribute("orderId", orderId);
        
        
        
        return "/order/kakaoSuccessPopup";
    }

    @GetMapping("/fail")
    public String kakaoPayFail(Model model) {
        model.addAttribute("code", -1);
        model.addAttribute("msg", "결제에 실패했습니다.");
        return "/order/fail";
    }

    @GetMapping("/cancel")
    public String kakaoPayCancel(Model model) {
        model.addAttribute("code", -2);
        model.addAttribute("msg", "결제가 취소되었습니다.");
        return "/order/fail";
    }
    
    @GetMapping("/complete")
    public String paymentCompletePage(HttpSession session, Model model) {
        Order order = (Order) session.getAttribute("complete_order");
        OrderDetail detail = (OrderDetail) session.getAttribute("complete_detail");

        if (order == null || detail == null) {
            return "redirect:/"; // 또는 오류 처리
        }

        model.addAttribute("order", order);
        model.addAttribute("detail", detail);

        // 사용 후 세션 제거
        session.removeAttribute("complete_order");
        session.removeAttribute("complete_detail");

        return "/order/complete";  // 결제 완료 정보 보여줄 JSP
    }
}
