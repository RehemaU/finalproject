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
    @GetMapping("/admin/sellerList")
    public String sellerList(@RequestParam(value = "keyword", required = false) String keyword,
                             @RequestParam(value = "page", defaultValue = "1") int page,
                             Model model) {

        int pageSize = 10;
        int startRow = (page - 1) * pageSize + 1;
        int endRow = page * pageSize;

        Map<String, Object> param = new HashMap<>();
        param.put("keyword", keyword);
        param.put("start", startRow);
        param.put("end", endRow);

        List<Seller> sellerList = adminService.getSellerList(param);
        int totalCount = adminService.getSellerCount(param);
        int totalPage = (int) Math.ceil((double) totalCount / pageSize);

        model.addAttribute("sellerList", sellerList);
        model.addAttribute("curPage", page);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("keyword", keyword);
        model.addAttribute("totalCount", totalCount);

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
    public String userList(@RequestParam(value = "keyword", required = false) String keyword,
                           @RequestParam(value = "page", defaultValue = "1") int curPage,
                           Model model) {

        int pageSize = 10;
        int startRow = (curPage - 1) * pageSize;
        int endRow = curPage * pageSize;
        // 검색 및 페이징 파라미터 Map
        Map<String, Object> param = new HashMap<>();
        param.put("keyword", keyword);
        param.put("startRow", startRow);
        param.put("endRow", endRow);

        // 검색된 사용자 목록 및 총 카운트
        List<User> userList = adminService.getUsersWithPaging(param);
        int totalCount = adminService.getUserCount(param);
        int totalPage = (int) Math.ceil((double) totalCount / pageSize);

        // JSP에 데이터 전달
        model.addAttribute("userList", userList);
        model.addAttribute("keyword", keyword);
        model.addAttribute("curPage", curPage);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("totalCount", totalCount);

        return "/admin/userList";
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
    
    
 // ✅ 숙소 목록 조회 (전체 or 요청 대기만 조회)
    @GetMapping("/admin/accommList")
    public String accommList(@RequestParam(value = "keyword", required = false) String keyword,
                             @RequestParam(value = "status", required = false) String status,
                             @RequestParam(value = "page", defaultValue = "1") int page,
                             Model model) {
    	 System.out.println("▶ 숙소 리스트 요청: keyword=" + keyword + ", status=" + status + ", page=" + page);
    	 if ("ALL".equals(status)) {
    		    status = null;
    		}
        int pageSize = 10;
        int startRow = (page - 1) * pageSize + 1;
        int endRow = page * pageSize;
        
        Map<String, Object> param = new HashMap<>();
        param.put("keyword", keyword);
        param.put("status", status); // 'N' 또는 null
        param.put("start", startRow);
        param.put("end", endRow);

        List<Map<String, Object>> accommList = adminService.getAccommList(param);
        int totalCount = adminService.getAccommCount(param);
        int totalPage = (int) Math.ceil((double) totalCount / pageSize);

        model.addAttribute("accommList", accommList);
        model.addAttribute("curPage", page);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("keyword", keyword);
        model.addAttribute("status", status);
        model.addAttribute("totalCount", totalCount);

        
        
        int blockSize = 10;
        int blockStart = ((page - 1) / blockSize) * blockSize + 1;
        int blockEnd = Math.min(blockStart + blockSize - 1, totalPage);

        model.addAttribute("blockStart", blockStart);
        model.addAttribute("blockEnd", blockEnd);
        
        return "/admin/accommList";
    }
    
 // ✅ 숙소 승인 처리 (ACCOMM_STATUS = 'Y'로 변경)
    @PostMapping("/admin/approveAccomm")
    @ResponseBody
    public Map<String, Object> approveAccomm(@RequestParam String accommId) {
        Map<String, Object> result = new HashMap<>();

        boolean success = adminService.approveAccomm(accommId); // → ACCOMM_STATUS = 'Y' 업데이트
        result.put("code", success ? 0 : -1);

        return result;
    }
}
