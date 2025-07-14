package com.sist.web.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.sist.web.model.AccommodationRoom;
import com.sist.web.service.RoomManageService;

@Controller("accommRoomManageController")
public class RoomManageController {

    @Autowired
    private RoomManageService roomManageService;


    // 객실 등록 처리
    @RequestMapping(value = "/seller/room/add", method = RequestMethod.POST)
    public String insertRoom(
        @RequestParam("roomImageFile") MultipartFile roomImageFile,
        AccommodationRoom room,
        HttpSession session,
        HttpServletRequest request
    ) {
        String sellerId = (String) session.getAttribute("sellerId");
        if (sellerId == null) {
            return "redirect:/user/login";
        }

        // 업로드 경로 설정
        String uploadPath = request.getServletContext().getRealPath("/resources/upload/room/");
        File dir = new File(uploadPath);
        if (!dir.exists()) {
            dir.mkdirs(); // 폴더 없으면 생성
        }

        // 업로드 파일명 처리
        if (roomImageFile != null && !roomImageFile.isEmpty()) {
            String originName = roomImageFile.getOriginalFilename();
            String extension = originName.substring(originName.lastIndexOf("."));
            String uuidName = UUID.randomUUID().toString() + extension;
            File dest = new File(uploadPath, uuidName);

            try {
                roomImageFile.transferTo(dest);
                room.setRoomImage("/resources/upload/room/" + uuidName); // DB에는 상대경로 저장
            } catch (IOException e) {
                e.printStackTrace();
                return "redirect:/seller/roomList?accommId=" + room.getAccommId();
            }
        }

        // DB 등록
        roomManageService.insertRoom(room);
        return "redirect:/seller/roomList?accommId=" + room.getAccommId();
    }


    // 객실 리스트
    @RequestMapping(value = "/seller/roomList", method = RequestMethod.GET)
    public String roomList(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) {
        String sellerId = (String) session.getAttribute("sellerId");
        if (sellerId == null) return "redirect:/user/login";

        String accommId = request.getParameter("accommId");
        List<AccommodationRoom> roomList = roomManageService.findRoomsByAccomm(accommId);
        model.addAttribute("roomList", roomList);
        return "/seller/roomList";
    }
}