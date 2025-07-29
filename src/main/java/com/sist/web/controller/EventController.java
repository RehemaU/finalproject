package com.sist.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.common.util.StringUtil;
import com.sist.web.model.Event;
import com.sist.web.service.EventService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("eventController")
public class EventController {
    private static final Logger logger = LoggerFactory.getLogger(EventController.class);

    @Autowired
    private EventService eventService;

    @Value("#{env['auth.cookie.name']}")
    private String AUTH_COOKIE_NAME;

    /**
     * ✅ 테스트용 세션 로그인 설정
     */
    @RequestMapping("/event/testLogin")
    @ResponseBody
    public String testLogin(HttpServletRequest request) {
        String testUserId = "user1";
        request.getSession().setAttribute("userId", testUserId);
        return "<h3>✅ 세션 설정 완료: userId = " + testUserId + "</h3><a href='/event/testStatus'>[세션 확인]</a>";
    }

    /**
     * ✅ 테스트용 세션 상태 확인
     */
    @RequestMapping("/event/testStatus")
    @ResponseBody
    public String checkSession(HttpServletRequest request) {
        String userId = (String) request.getSession().getAttribute("userId");
        return userId != null ?
            "<h3>🔐 세션에 userId 있음: " + userId + "</h3>" :
            "<h3>⚠️ 세션에 userId 없음</h3>";
    }

    /**
     * ✅ 로그아웃 처리
     */
    @RequestMapping("/event/logout")
    @ResponseBody
    public String logout(HttpServletRequest request) {
        request.getSession().removeAttribute("userId");
        return "<h3>👋 로그아웃 완료: 세션에서 userId 제거됨</h3>";
    }

    /**
     * ✅ 쿠폰 발급 Ajax 요청 처리
     */
    @PostMapping("/event/issueCoupon")
    @ResponseBody
    public Map<String, Object> issueCouponAjax(HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();

        String eventId = request.getParameter("eventId");
        String userId = (String) request.getSession().getAttribute("userId");
     
        if (userId == null || StringUtil.isEmpty(eventId)) {
            result.put("code", 1);
            result.put("msg", "로그인 또는 이벤트 ID가 누락되었습니다.");
            return result;
        }

        boolean success = eventService.issueCoupon(eventId, userId);

        if (success) {
            result.put("code", 0);
            result.put("msg", "쿠폰이 발급되었습니다!");
            Map<String, String> data = new HashMap<>();
            data.put("redirectUrl", "/event/eventList");
            result.put("data", data);
        } else {
            result.put("code", 1);
            result.put("msg", "이미 발급받았거나 수량이 부족합니다.");
        }

        return result;
    }

    /**
     * ✅ 쿠폰 발급 테스트용 페이지
     */
    @RequestMapping("/event/coupontest")
    public String couponTestPage() {
        return "/event/coupontest";
    }

    /**
     * ✅ 썸네일 스타일 이벤트 목록
     */
    @RequestMapping("/event/eventList")
    public String eventThumbnailListPage(ModelMap model) {
        try {
            int pageSize = 6;
            int startRow = 0;

            List<Event> activeEvents = eventService.getActiveEventsByPage(startRow, pageSize);
            List<Event> endedEvents = eventService.getEndedEvents();
            int totalCount = eventService.getActiveEventCount();

            model.addAttribute("activeEvents", activeEvents);
            model.addAttribute("hasMore", pageSize < totalCount);
            model.addAttribute("endedEvents", endedEvents);
        } catch (Exception e) {
            logger.error("[EventController] 이벤트 리스트 조회 중 오류", e);
            model.addAttribute("activeEvents", null);
            model.addAttribute("hasMore", false);
            model.addAttribute("endedEvents", null);
        }
        return "/event/eventList";
    }

    /**
     * ✅ 이벤트 상세보기 페이지
     */
    @RequestMapping("/event/eventDetail")
    public String eventDetailPage(HttpServletRequest request, ModelMap model) {
        String eventId = request.getParameter("eventId");

        if (StringUtil.isEmpty(eventId)) {
            model.addAttribute("errorMsg", "잘못된 접근입니다.");
            return "/error/404";
        }

        try {
            eventService.increaseEventCount(eventId);
            Event event = eventService.getEventById(eventId);
            logger.debug("✅ 쿠폰 ID 확인: {}", event.getCouponId());
            String fileName = eventId + ".png";
            event.setEventThumbnailUrl("/resources/eventimage/" + fileName);
            event.setEventImageUrl("/resources/eventdetailimage/" + fileName);

            logger.debug("🖼️ 이벤트 ID: {}, 썸네일: {}, 상세: {}, 쿠폰: {}",
            	    eventId, event.getEventThumbnailUrl(), event.getEventImageUrl(), event.getCouponId());

            model.addAttribute("event", event);
        } catch (Exception e) {
            logger.error("[EventController] 이벤트 상세 조회 오류", e);
            model.addAttribute("errorMsg", "이벤트 조회 중 오류가 발생했습니다.");
            return "/error/500";
        }

        return "/event/eventDetail";
    }

    /**
     * ✅ 게시판 스타일 이벤트 목록 (페이징 포함)
     */
    @GetMapping("/event/ajaxSearch")
    @ResponseBody
    public Map<String, Object> ajaxSearch(
            @RequestParam(name = "searchKeyword", required = false) String keyword,
            @RequestParam(name = "page", defaultValue = "1") int curPage,
            @RequestParam(name = "status", defaultValue = "active") String status) { // 🔥 status 추가

        Map<String, Object> result = new HashMap<>();
        int pageSize = 10;
        int startRow = (curPage - 1) * pageSize;

        //  Map에 검색 파라미터들 추가
        Map<String, Object> param = new HashMap<>();
        param.put("keyword", keyword);
        param.put("status", status);        // 
        param.put("startRow", startRow);
        param.put("pageSize", pageSize);
        

        //  DB 조회
        int totalCount = eventService.getSearchEventCount(param);
        int totalPage = (int) Math.ceil((double) totalCount / pageSize);
        int startNum = totalCount - startRow;
        
        List<Event> eventList = eventService.searchEventList(param);

        
        //  HTML 테이블 생성
        StringBuilder tableHtml = new StringBuilder();
        for (int i = 0; i < eventList.size(); i++) {
            Event event = eventList.get(i);
            int num = startNum - i;

            tableHtml.append("<tr>");
            tableHtml.append("<td>").append(num).append("</td>");
            tableHtml.append("<td class='title-col'>")
                     .append("<a href='/event/eventDetail?eventId=").append(event.getEventId()).append("'>")
                     .append(event.getEventTitle()).append("</a></td>");
            tableHtml.append("<td>").append(event.getEventCount()).append("</td>");
            tableHtml.append("<td>").append(event.getEventRegdate().substring(0, 10)).append("</td>");
            tableHtml.append("</tr>");
        }

        //  페이지네이션 HTML 생성
        StringBuilder paginationHtml = new StringBuilder();

		if (curPage > 1) {
		    paginationHtml.append("<a href='?page=").append(curPage - 1).append("' class='prev'>« 이전</a>");
		}
		
		for (int i = 1; i <= totalPage; i++) {
		    paginationHtml.append("<a href='?page=").append(i).append("'")
		                  .append(i == curPage ? " class='active'" : "")
		                  .append(">").append(i).append("</a>");
		}
		
		if (curPage < totalPage) {
		    paginationHtml.append("<a href='?page=").append(curPage + 1).append("' class='next'>다음 »</a>");
		}

        result.put("tableHtml", tableHtml.toString());
        result.put("paginationHtml", paginationHtml.toString());

        return result;
    }

    
    @RequestMapping("/event/eventBoardList")
    public String eventBoardListPage(HttpServletRequest request, ModelMap model) {
        int curPage = 1;
        int pageSize = 10;

        String keyword = request.getParameter("searchKeyword");
        String status = request.getParameter("status"); //  추가됨 ("active" or "closed")
        if (status == null || status.isEmpty()) {
            status = "active"; // 기본값
        }

        int startRow = (curPage - 1) * pageSize;

        //  검색 파라미터 Map 구성
        Map<String, Object> param = new HashMap<>();
        param.put("keyword", keyword);
        param.put("status", status);
        param.put("startRow", startRow);
        param.put("pageSize", pageSize);

        int totalCount = eventService.getSearchEventCount(param);
        int totalPage = (int) Math.ceil((double) totalCount / pageSize);
        int allCount = eventService.getTotalEventCount();         // 전체 이벤트 수
        List<Event> eventList = eventService.searchEventList(param);

        //  JSP로 데이터 전달
        model.addAttribute("eventList", eventList);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("curPage", curPage);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("allCount", allCount);                 // 전체 건수도 전달
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("searchKeyword", keyword);
        model.addAttribute("status", status); // 🔥 상태 필터도 뷰에 전달

        return "/event/eventBoardList";
    }
    
    @GetMapping("/event/activeListAjax")
    @ResponseBody
    public Map<String, Object> getActiveListAjax(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "6") int size) {

        logger.debug("Ajax 이벤트 요청 page={}, size={}", page, size);

        Map<String, Object> result = new HashMap<>();
        int startRow = (page - 1) * size;

        List<Event> events = eventService.getActiveEventsByPage(startRow, size);
        int totalCount = eventService.getActiveEventCount();

        result.put("events", events);
        result.put("hasMore", startRow + size < totalCount);
        result.put("totalCount", totalCount);
        return result;
    }
}