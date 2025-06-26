package com.sist.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import com.sist.common.util.StringUtil;
import com.sist.web.model.Response;
import com.sist.web.service.EventService;
import com.sist.web.util.CookieUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller("eventController")
@RequestMapping("/event")
public class EventController {
	private static final Logger logger = LoggerFactory.getLogger(EventController.class);

	@Autowired
	private EventService eventService;

	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;

	/**
	 * 쿠폰 발급 요청 (Ajax)
	 */
	
	@RequestMapping(value = "/testLogin", produces = "text/plain; charset=UTF-8")
	@ResponseBody
	public String testLogin(HttpServletRequest request) {
	    String testUserId = "user1";  // 테스트용 유저 ID
	    request.getSession().setAttribute("userId", testUserId);
	    return "세션 설정 완료: userId = " + testUserId;
	}
	
	@RequestMapping(value = "/checkSession", produces = "text/plain; charset=UTF-8")
	@ResponseBody
	public String checkSession(HttpServletRequest request) {
	    String userId = (String) request.getSession().getAttribute("userId");

	    if (userId != null) {
	        return "세션에 userId 있음: " + userId;
	    } else {
	        return "세션에 userId 없음";
	    }
	}
	
	@RequestMapping(value = "/logout", produces = "text/plain; charset=UTF-8")
	@ResponseBody
	public String logout(HttpServletRequest request) {
	    request.getSession().removeAttribute("userId");
	    return "로그아웃 완료: 세션에서 userId 제거됨";
	}
	
	
	@PostMapping("/issueCoupon")
	@ResponseBody
	public Response<JsonObject> issueCoupon(HttpServletRequest request, HttpServletResponse response) {
		Response<JsonObject> res = new Response<>();
		JsonObject json = new JsonObject();

		String eventId = request.getParameter("eventId");
		//String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME); // 쿠키에서 로그인 ID 확인
		String userId = (String) request.getSession().getAttribute("userId"); //일단 테스트 세션으로하고있음 0625 영우
		logger.debug("[EventController] issueCoupon called - eventId: {}, userId: {}", eventId, userId);

		// 로그인 여부 확인
		if (StringUtil.isEmpty(userId)) {
			res.setResponse(1, "로그인이 필요합니다.");
			return res;
		}

		// 파라미터 검증
		if (StringUtil.isEmpty(eventId)) {
			res.setResponse(1, "잘못된 요청입니다.");
			return res;
		}
		logger.debug("[EventController] issueCoupon called - eventId: {}, userId: {}", eventId, userId);
		// 쿠폰 발급 시도
		boolean result = eventService.issueCoupon(eventId, userId);

		if (result) {
			json.addProperty("redirectUrl", "/mypage/couponList");
			res.setResponse(0, "쿠폰이 성공적으로 발급되었습니다.", json);
		} else {
			res.setResponse(1, "이미 발급받았거나 수량이 부족합니다.");
		}

		return res;
	}
}