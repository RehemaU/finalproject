package com.sist.web.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import com.sist.web.model.Like;
import com.sist.web.service.LikeService;

@Controller
@RequestMapping("/like")
public class LikeController {
    
    @Autowired
    private LikeService likeService;
    
    @PostMapping("/toggle")
    @ResponseBody
    public Map<String, Object> toggleLike(
            @RequestParam("spotId") String spotId,
            HttpSession session) {
        session.setAttribute("USER_ID", "test");  // 원하는 아이디로 고정

        Map<String, Object> response = new HashMap<>();
        
        // 세션에서 사용자 ID 가져오기 (로그인 체크)
        String userId = (String) session.getAttribute("USER_ID");

        if (userId == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return response;
        }
        
        try {
            boolean isLiked = likeService.toggleLike(userId, spotId);
            int likeCount = likeService.getLikeCount(spotId);
            
            response.put("success", true);
            response.put("isLiked", isLiked);
            response.put("likeCount", likeCount);
            response.put("message", isLiked ? "찜 추가되었습니다." : "찜 해제되었습니다.");
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "오류가 발생했습니다.");
            e.printStackTrace();
        }
        
        return response;
    }
    
    @GetMapping("/check")
    @ResponseBody
    public Map<String, Object> checkLike(
            @RequestParam("spotId") String spotId,
            HttpSession session) {
        session.setAttribute("USER_ID", "test");

        Map<String, Object> response = new HashMap<>();
        String userId = (String) session.getAttribute("USER_ID");
        
        if (userId == null) {
            response.put("isLiked", false);
            response.put("likeCount", likeService.getLikeCount(spotId));
        } else {
            response.put("isLiked", likeService.isLiked(userId, spotId));
            response.put("likeCount", likeService.getLikeCount(spotId));
        }
        
        return response;
    }
    @GetMapping("/spotIds")
    @ResponseBody
    public List<String> getLikedTourSpotIds(HttpSession session) {
        String userId = (String) session.getAttribute("USER_ID");

        if (userId == null) return Collections.emptyList();

        List<Like> likes = likeService.getUserLikes(userId);

        return likes.stream()
                .filter(Objects::nonNull) // ✅ Like 객체가 null인지 체크
                .map(Like::getSpotId)
                .filter(Objects::nonNull) // ✅ spotId가 null인지 체크
                .filter(id -> id.startsWith("T_")) // 관광지 찜만 필터
                .collect(Collectors.toList());
    }

    /* ---------- 숙소 찜 ---------- */
    @PostMapping("/accomm/toggle")
    @ResponseBody
    public Map<String, Object> toggleAccommLike(@RequestParam("spotId") String spotId, HttpSession session) {
        session.setAttribute("USER_ID", "test");
        String userId = (String) session.getAttribute("USER_ID");
        Map<String, Object> response = new HashMap<>();

        try {
            boolean isLiked = likeService.toggleAccommLike(userId, spotId);
            int likeCount = likeService.getAccommLikeCount(spotId);

            response.put("success", true);
            response.put("isLiked", isLiked);
            response.put("likeCount", likeCount);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "오류 발생");
        }

        return response;
    }

    @GetMapping("/accomm/check")
    @ResponseBody
    public Map<String, Object> checkAccommLike(@RequestParam("spotId") String spotId, HttpSession session) {
        session.setAttribute("USER_ID", "test");
        String userId = (String) session.getAttribute("USER_ID");

        Map<String, Object> response = new HashMap<>();
        response.put("isLiked", likeService.isAccommLiked(userId, spotId));
        response.put("likeCount", likeService.getAccommLikeCount(spotId));
        return response;
    }

    /* 공통 좋아요 목록 (선택적) */
    @GetMapping("/list")
    public String likeList(HttpSession session, ModelMap model) {
        // 테스트용 세션 (실제에선 로그인 후 세션 주입될 것)
        session.setAttribute("USER_ID", "test");
        String userId = (String) session.getAttribute("USER_ID");

        // 관광지 찜 리스트
        List<Like> likedTourList = likeService.getUserLikesWithDetail(userId);
        model.addAttribute("likedTourList", likedTourList);

        // 숙소 찜 리스트
        List<Like> likedAccommList = likeService.getAccommLikesByUser(userId);
        model.addAttribute("likedAccommList", likedAccommList);

        return "/like/list";  // like/list.jsp 로 포워딩
    }
    
    @GetMapping("/accommIds")
    @ResponseBody
    public List<String> getLikedAccommIds(HttpSession session) {
        session.setAttribute("USER_ID", "test");
        String userId = (String) session.getAttribute("USER_ID");

        if (userId == null) return Collections.emptyList();

        List<Like> allLikes = likeService.getUserLikes(userId);

        if (allLikes == null || allLikes.isEmpty()) return Collections.emptyList();

        return allLikes.stream()
                .filter(Objects::nonNull)
                .map(Like::getSpotId)
                .filter(Objects::nonNull)
                .filter(id -> id.startsWith("A_"))
                .collect(Collectors.toList());
    }



}