package com.sist.web.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
	 private static Logger logger = LoggerFactory.getLogger(RoomManageController.class);
	    
	    @Autowired
	    private RoomManageService roomManageService;
	    
		  @RequestMapping(value = "/accomm/accommRoomRegForm", method = RequestMethod.GET)
		  public String sellerInfo(HttpServletRequest request, Model model)
		  {
		      String accommId = request.getParameter("accommId");  // 숙소 ID 받기
		      model.addAttribute("accommId", accommId);            // 뷰에서 사용할 수 있도록 모델에 담기
		      return "/accomm/accommRoomRegForm";
		  }

	    // 객실 등록 처리
	    @RequestMapping(value = "/seller/roomAdd", method = RequestMethod.POST)
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
	        
	        logger.debug("객실 등록 요청 - accommId: {}, roomName: {}", room.getAccommId(), room.getRoomName());
	        
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
	                logger.debug("객실 이미지 업로드 완료: {}", uuidName);
	            } catch (IOException e) {
	                logger.error("객실 이미지 업로드 실패", e);
	                return "redirect:/seller/roomList?accommId=" + room.getAccommId();
	            }
	        }
	        room.setBathroom(room.getBathroom() != null ? "Y" : "N");  // ✔ 추가
	        room.setBath(room.getBath() != null ? "Y" : "N");          // ✔ 추가
	        room.setTv(room.getTv() != null ? "Y" : "N");              // ✔ 추가
	        room.setPc(room.getPc() != null ? "Y" : "N");              // ✔ 추가
	        room.setInternet(room.getInternet() != null ? "Y" : "N");  // ✔ 추가
	        room.setRefrigerator(room.getRefrigerator() != null ? "Y" : "N"); // ✔ 추가
	        room.setSofa(room.getSofa() != null ? "Y" : "N");          // ✔ 추가
	        room.setTable(room.getTable() != null ? "Y" : "N");        // ✔ 추가
	        room.setDryer(room.getDryer() != null ? "Y" : "N");    
	        // DB 등록
	        try {
	            roomManageService.insertRoom(room);
	            logger.debug("객실 등록 완료");
	        } catch (Exception e) {
	            logger.error("객실 등록 실패", e);
	        }
	        
	        return "redirect:/seller/roomList?accommId=" + room.getAccommId();
	    }
	    
	    @RequestMapping(value = "/seller/roomList", method = RequestMethod.GET)
	    public String roomList(
	            @RequestParam("accommId") String accommId,
	            Model model,
	            HttpSession session
	    ) {
	        String sellerId = (String) session.getAttribute("sellerId");
	        if (sellerId == null) return "redirect:/user/login";

	        logger.debug("객실 리스트 조회 - accommId: {}", accommId);

	        if (accommId == null || accommId.trim().isEmpty()) {
	            logger.warn("accommId가 null 또는 빈 문자열입니다.");
	            model.addAttribute("errorMsg", "숙소 ID가 올바르지 않습니다.");
	            return "/error";
	        }

	        try {
	            List<AccommodationRoom> roomList = roomManageService.findRoomsByAccomm(accommId);
	            logger.debug("조회된 객실 수: {}", roomList != null ? roomList.size() : 0);

	            model.addAttribute("roomList", roomList);
	            model.addAttribute("accommId", accommId);  // 객실 추가 버튼에서 사용

	        } catch (Exception e) {
	            logger.error("객실 리스트 조회 실패", e);
	            model.addAttribute("errorMsg", "객실 리스트 조회 중 오류가 발생했습니다.");
	            return "/error";
	        }

	        return "/seller/roomList";
	    }
}