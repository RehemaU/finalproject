package com.sist.web.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sist.web.model.Notice;
import com.sist.web.service.NoticeService;


@Controller("noticeController")
public class NoticeController {

	@Autowired
    private NoticeService noticeService;
	
	private static final Logger logger = LoggerFactory.getLogger(EventController.class);
	
	
	 @RequestMapping("/notice/noticeList")
	    public String noticeList(@RequestParam(value="page", defaultValue="1") int page, Model model) {
	        int pageSize = 10;
	        int startRow = (page - 1) * pageSize;

	        List<Notice> noticeList = noticeService.getNoticeList(startRow, pageSize);
	        int totalCount = noticeService.getNoticeCount();
	        
	        model.addAttribute("noticeList", noticeList);
	        model.addAttribute("totalCount", totalCount);
	        model.addAttribute("currentPage", page);
	        model.addAttribute("pageSize", pageSize);
	        // 🔍 로그로 디버깅
	        System.out.println("총 개수: " + totalCount);
	        System.out.println("현재 페이지: " + page);
	        System.out.println("페이지 크기: " + pageSize);
	        for (int i = 0; i < noticeList.size(); i++) {
	            Notice e = noticeList.get(i);
	            System.out.println("[" + i + "] ID: " + e.getNoticeId() + ", 제목: " + e.getNoticeTitle() + ", 날짜: " + e.getNoticeRegdate());
	        }
	        return "/notice/noticeList"; // /WEB-INF/views/notice/noticeList.jsp
	    }
	
}
