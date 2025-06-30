package com.sist.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.common.util.StringUtil;
import com.sist.web.service.EventService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("eventController")
public class EventController {
    private static final Logger logger = LoggerFactory.getLogger(EventController.class);

    @Autowired
    private EventService eventService;

    @Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;

    /**
     * 테스트용 로그인 세션 설정 (JSP용)
     */
    @RequestMapping(value = "/event/testLogin")
    @ResponseBody
    public String testLogin(HttpServletRequest request) {
        String testUserId = "user1";  // 테스트용 유저 ID
        request.getSession().setAttribute("userId", testUserId);

        return "<h3>✅ 세션 설정 완료: userId = " + testUserId + "</h3>"
             + "<a href='/event/testStatus'>[세션 확인]</a>";
    }

    /**
     * 세션 유무 확인 (JSP 출력용)
     */
    @RequestMapping(value = "/event/testStatus")
    @ResponseBody
    public String checkSession(HttpServletRequest request) {
        String userId = (String) request.getSession().getAttribute("userId");

        if (userId != null) {
            return "<h3>🔐 세션에 userId 있음: " + userId + "</h3>";
        } else {
            return "<h3>⚠️ 세션에 userId 없음</h3>";
        }
    }

    /**
     * 로그아웃 (세션 제거)
     */
    @RequestMapping(value = "/event/logout")
    @ResponseBody
    public String logout(HttpServletRequest request) {
        request.getSession().removeAttribute("userId");

        return "<h3>👋 로그아웃 완료: 세션에서 userId 제거됨</h3>";
    }

    /**
     * 쿠폰 발급 요청 처리
     */
    @ResponseBody
    @PostMapping("/event/issueCoupon")
    public Map<String, Object> issueCouponAjax(HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();

        String eventId = request.getParameter("eventId");
        String userId = (String) request.getSession().getAttribute("userId");

        if (userId == null) {
            result.put("code", 1);
            result.put("msg", "로그인이 필요합니다.");
            return result;
        }

        if (eventId == null || eventId.trim().isEmpty()) {
            result.put("code", 1);
            result.put("msg", "이벤트 ID가 누락되었습니다.");
            return result;
        }

        boolean success = eventService.issueCoupon(eventId, userId);

        if (success) {
            result.put("code", 0);
            result.put("msg", "쿠폰이 발급되었습니다!");

            Map<String, String> data = new HashMap<>();
            data.put("redirectUrl", "/mypage/couponList");

            result.put("data", data);
        } else {
            result.put("code", 1);
            result.put("msg", "이미 발급받았거나 수량이 부족합니다.");
        }

        return result;
    }

    /**
     * 쿠폰 발급 테스트용 페이지
     */
    @RequestMapping(value = "/event/coupontest")
    public String couponTestPage() {
        return "/event/coupontest";  // ← /WEB-INF/views/event/coupontest.jsp
    }
    
    /**
     * 이벤트 리스트 페이지
     */
    @RequestMapping(value = "/event/eventList")
    public String eventListPage(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        try {
            model.addAttribute("activeEvents", eventService.getActiveEvents());
            model.addAttribute("endedEvents", eventService.getEndedEvents());
        } catch (Exception e) {
            logger.error("[EventController] 이벤트 리스트 조회 중 오류", e);
            model.addAttribute("activeEvents", null);
            model.addAttribute("endedEvents", null);
        }

        return "/event/eventList";  // => /WEB-INF/views/event/eventList.jsp
    }
    
    /**
     * 이벤트 상세페이지
     */
    @RequestMapping(value = "/event/view")
    public String eventView(HttpServletRequest request, ModelMap model) {
        String eventId = request.getParameter("eventId");

        if (StringUtil.isEmpty(eventId)) {
            model.addAttribute("errorMsg", "잘못된 접근입니다.");
            return "/error/404"; // 또는 적절한 에러 페이지
        }

        try {
            // 조회수 증가
            eventService.increaseEventCount(eventId);

            // 이벤트 조회
            model.addAttribute("event", eventService.getEventById(eventId));
        } catch (Exception e) {
            logger.error("[EventController] 이벤트 상세 조회 오류", e);
            model.addAttribute("errorMsg", "이벤트 조회 중 오류가 발생했습니다.");
            return "/error/500"; // 또는 적절한 에러 페이지
        }

        return "/event/eventDetail"; // → /WEB-INF/views/event/eventDetail.jsp
    }
    
}
