package com.sist.web.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import com.sist.web.service.LikeService;

@Controller("likeController")
@RequestMapping("/like")
public class LikeController {

    @Autowired
    private LikeService likeService;

    /** 좋아요 추가 */
    @PostMapping("/add")
    @ResponseBody
    public String addLike(@RequestParam("spotId") String spotId,
                          HttpSession session) {

        String userId = (String) session.getAttribute("userId");
        if (userId == null) return "NOT_LOGIN";

        try {
            boolean done = likeService.addLike(userId, spotId);
            return done ? "LIKED" : "ALREADY";
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR";
        }
    }

    /** 좋아요 취소 */
    @PostMapping("/delete")
    @ResponseBody
    public String deleteLike(@RequestParam("spotId") String spotId,
                             HttpSession session) {

        String userId = (String) session.getAttribute("userId");
        if (userId == null) return "NOT_LOGIN";

        try {
            likeService.removeLike(userId, spotId);
            return "UNLIKED";
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR";
        }
    }
    @GetMapping("/list")
    public String likeList(ModelMap model, HttpSession session) {

        String userId = (String) session.getAttribute("userId");
        if (userId == null) return "redirect:/user/login";

        List<Map<String, Object>> likedList = likeService.getLikedSpots(userId);
        model.addAttribute("likedList", likedList);

        return "/like/likeList";   // → JSP
    }
}
