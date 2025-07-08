package com.sist.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.common.util.StringUtil;
import com.sist.web.model.Admin;
import com.sist.web.service.AdminService;

@Controller("adminController")
public class AdminController {

    private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

    @Autowired
    private AdminService adminService;
    
    
    /**
     * ✅ 관리자 로그인 페이지 요청
     */
    @RequestMapping("/admin/adminLogin")
    public String adminLoginPage() {
        logger.info("[adminLoginPage] 관리자 로그인 페이지 호출됨");
        return "/admin/adminLogin"; // /WEB-INF/views/admin/adminLogin.jsp
    }
    
    
    @RequestMapping("/admin/loginProc")
    @ResponseBody
    public Map<String, Object> adminLoginProc(HttpServletRequest request) {
        String adminId = request.getParameter("adminId");
        String adminPassword = request.getParameter("adminPassword");

        Map<String, Object> result = new HashMap<>();

        if (StringUtil.isEmpty(adminId) || StringUtil.isEmpty(adminPassword)) {
            result.put("code", 400); // 잘못된 요청
            return result;
        }

        logger.info("[adminLoginProc] adminId: " + adminId);
        
        Admin admin = adminService.getAdminById(adminId);

        logger.info("[adminLoginProc] adminId: " + adminId);
        logger.info("[adminLoginProc] admin: " + (admin != null ? admin.toString() : "null"));
        
        if (admin == null) {
            result.put("code", 404); // ID 없음
        } else if (!admin.getAdminPassword().equals(adminPassword)) {
            result.put("code", -1); // 비밀번호 불일치
        } else {
            request.getSession().setAttribute("adminLogin", admin);
            result.put("code", 0); // 로그인 성공
            
            
        }

        return result;
    }
    @RequestMapping("/admin/dashboard")
    public String adminDashboardPage() {
        logger.info("[adminDashboardPage] 관리자 대시보드 페이지 호출됨");
        return "/admin/dashboard"; // => /WEB-INF/views/admin/dashboard.jsp
    }
    
    
    @RequestMapping("/admin/logout")
    public String adminLogout(HttpServletRequest request) {
        // 세션 무효화
        request.getSession().invalidate();

        // 쿠키 제거는 필요 시 아래처럼 추가
        // CookieUtil.deleteCookie(request, response, "adminCookie");

        return "redirect:/admin/adminLogin";
    }
    
    

}
