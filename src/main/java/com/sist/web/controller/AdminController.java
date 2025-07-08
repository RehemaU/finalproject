package com.sist.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.sist.web.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.common.util.StringUtil;
import com.sist.web.model.Admin;
import com.sist.web.model.Seller;
import com.sist.web.service.AdminService;
import com.sist.web.service.SellerService;

@Controller("adminController")
public class AdminController {

    private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

    @Autowired
    private AdminService adminService;

    @Autowired
    private SellerService sellerService;

    @RequestMapping("/admin/adminLogin")
    public String adminLoginPage() {
        return "/admin/adminLogin";
    }

    @RequestMapping("/admin/loginProc")
    @ResponseBody
    public Map<String, Object> adminLoginProc(HttpServletRequest request) {
        String adminId = request.getParameter("adminId");
        String adminPassword = request.getParameter("adminPassword");

        Map<String, Object> result = new HashMap<>();

        if (StringUtil.isEmpty(adminId) || StringUtil.isEmpty(adminPassword)) {
            result.put("code", 400);
            return result;
        }

        Admin admin = adminService.getAdminById(adminId);

        if (admin == null) {
            result.put("code", 404);
        } else if (!admin.getAdminPassword().equals(adminPassword)) {
            result.put("code", -1);
        } else {
            request.getSession().setAttribute("adminLogin", admin);
            result.put("code", 0);
        }

        return result;
    }

    @RequestMapping("/admin/dashboard")
    public String adminDashboardPage() {
        return "/admin/dashboard";
    }

    @RequestMapping("/admin/logout")
    public String adminLogout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/admin/adminLogin";
    }

    /**
     * ✅ 판매자 목록 페이지
     */
    @RequestMapping("/admin/sellerList")
    public String sellerListPage(HttpServletRequest request, ModelMap model) {
        List<Seller> sellerList = adminService.sellerList();
        model.addAttribute("sellerList", sellerList);
        return "/admin/sellerList";
    }

    /**
     * ✅ 판매자 승인/취소 처리 (status: 'Y' 또는 'N')
     */
    @PostMapping("/admin/toggleSellerStatus")
    @ResponseBody
    public Map<String, Object> toggleSellerStatus(HttpServletRequest request) {
        String sellerId = request.getParameter("sellerId");
        String status = request.getParameter("status"); // Y or N

        Map<String, Object> result = new HashMap<>();
        if (StringUtil.isEmpty(sellerId) || StringUtil.isEmpty(status)) {
            result.put("code", 400);
            return result;
        }

        Map<String, Object> param = new HashMap<>();
        param.put("sellerId", sellerId);
        param.put("status", status);

        int updateCount = adminService.updateSellerStatus(param);
        result.put("code", updateCount > 0 ? 0 : -1);
        return result;
    }
    // ✅ 회원 목록 페이지
    @GetMapping("/admin/userList")
    public String userList(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
        List<User> userList;

        if (keyword != null && !keyword.trim().isEmpty()) {
            userList = adminService.searchUsersById(keyword);
        } else {
            userList = adminService.getAllUsers();
        }

        model.addAttribute("userList", userList);

        // Ajax 요청이면 userListAjax.jsp를 반환 (선택)
        return "/admin/userList"; // 그대로 사용해도 되고, 부분 렌더링용 별도 JSP도 가능
    }

    // ✅ 회원 탈퇴/복구 처리
    @PostMapping("/admin/toggleUserStatus")
    @ResponseBody
    public Map<String, Object> toggleUserStatus(@RequestParam String userId, @RequestParam String status) {
        boolean success = adminService.updateUserStatus(userId, status);

        Map<String, Object> result = new HashMap<>();
        result.put("code", success ? 0 : -1);
        return result;
    }
}
