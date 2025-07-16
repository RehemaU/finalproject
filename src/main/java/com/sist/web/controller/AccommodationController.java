package com.sist.web.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.sist.web.model.Accommodation;
import com.sist.web.model.AccommodationRoom;
import com.sist.web.model.Region;
import com.sist.web.model.Review;
import com.sist.web.model.RoomAvailabilityRequest;
import com.sist.web.model.RoomPriceRequest;
import com.sist.web.model.RoomPriceResult;
import com.sist.web.model.Sigungu;
import com.sist.web.model.UserCoupon;
import com.sist.web.service.AccommodationRoomPriceService;
import com.sist.web.service.AccommodationRoomService;
import com.sist.web.service.AccommodationService;
import com.sist.web.service.EventService;
import com.sist.web.service.RegionService;
import com.sist.web.service.ReviewService;
import com.sist.web.service.SigunguService;
import com.sist.web.service.UserCouponService;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller("AcommodationController")
public class AccommodationController {
	// 커밋용 추가
    @Autowired
    private AccommodationService accommodationService;
    
    @Autowired
    private UserCouponService userCouponService;

    @Autowired
    private AccommodationRoomService accommodationRoomService;
    
    @Autowired
    private AccommodationRoomPriceService accommodationRoomPriceService;
    @Autowired
    private SigunguService sigunguService;
    
    @Autowired
    private RegionService regionService;
    
    @Autowired
    private ReviewService reviewService;
    
    
    @GetMapping("/order/fail")
    public String orderFail(HttpServletRequest request) {
        String referer = request.getHeader("Referer");
        return "redirect:" + (referer != null ? referer : "/fallback");
    }
    
    @GetMapping("/list")
    public String accommodationList() {
    	
    	return "";
    }

    @GetMapping("/syncAccommodation")
    public String syncAccommodation() {

        try {
            accommodationService.syncAllAccommodations();  // 전체 시군구별 숙박 동기화 실행
            return "전체 숙박 동기화 완료.";
        } catch (Exception e) {
            e.printStackTrace();
            return "에러 발생: " + e.getMessage();
        }
    }
    @GetMapping("/accommodation/listAll")
    @ResponseBody
    public List<Accommodation> getAllAccommodations() {
        return accommodationService.getAllAccommodations(); // DB에서 전체 숙소 조회
    }

    @GetMapping("/accomm/list")
    public String listPage(@RequestParam(value = "regionId", required = false) String regionId,  // ✅ 수정
                           Model model, HttpSession session) {

        List<Sigungu> sigunguList = sigunguService.getAllSigungus();
        List<Region> regionList = regionService.getAllRegions();
        model.addAttribute("sigunguList", sigunguList);
        model.addAttribute("regionList", regionList);
        model.addAttribute("regionId", regionId);  // ✅ model에도 regionId로

        // 숙소 필터링
        if (regionId != null && !regionId.isEmpty()) {
            List<Sigungu> selectedSigunguList = sigunguList.stream()
                    .filter(s -> s.getRegionId().equals(regionId))  // ✅ 변수명 반영
                    .collect(Collectors.toList());

            String userId = (String) session.getAttribute("userId");
//            List<Accommodation> results = accommodationService.findBySigunguList(selectedSigunguList, userId);
//            model.addAttribute("results", results);
            model.addAttribute("filtering", true);
//            System.out.println("초기 로딩 regionId: " + regionId + " → 숙소 개수: " + results.size());  // ✅ 로그도 수정
        }

        return "/accomm/list";
    }

    // 어떻게 list를 들어가도 결국 처음에 filterList를 호출한다.
    @PostMapping("/accomm/filterList")
    public String filterList(@RequestBody Map<String, Object> requestBody,
                             HttpSession session,
                             Model model) {
        String userId = (String) session.getAttribute("userId");

        // 1. 페이지 파라미터 파싱
        int page = ((Number) requestBody.getOrDefault("page", 1)).intValue();

        // 2. 시군구 리스트 파싱
        List<Map<String, Object>> rawList = (List<Map<String, Object>>) requestBody.get("sigunguList");
        List<Sigungu> sigunguList = rawList.stream().map(map -> {
            Sigungu s = new Sigungu();
            s.setRegionId((String) map.get("regionId"));
            s.setSigunguId((String) map.get("sigunguId"));
            return s;
        }).collect(Collectors.toList());

        // 3. 페이징 설정
        int pageSize = 20;
        int pageBlockSize = 10;

        int totalCount = accommodationService.getAccommodationcount(sigunguList);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        int startPage = ((page - 1) / pageBlockSize) * pageBlockSize + 1;
        int endPage = Math.min(startPage + pageBlockSize - 1, totalPages);
        boolean hasPrev = startPage > 1;
        boolean hasNext = endPage < totalPages;

        // 4. 숙소 리스트 조회 (with 페이징)
        List<Accommodation> results = accommodationService.findBySigunguList(sigunguList, userId, page);

        // 5. 리뷰 정보 추가
        for (Accommodation accomm : results) {
            double rating = reviewService.reviewRatingAvg(accomm.getAccomId());
            int accommCount = reviewService.reviewAccommCount(accomm.getAccomId());
            accomm.setRating(rating);
            accomm.setAccommCount(accommCount);
        }

        // 6. 모델에 추가
        model.addAttribute("results", results);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("hasPrev", hasPrev);
        model.addAttribute("hasNext", hasNext);

        return "/accomm/cardList";
    }

    
    @GetMapping("/accomm/accommDetail")
    public String accommDetail(@RequestParam("accommId") String accommId, Model model) {
    	List<AccommodationRoom> roomList = accommodationRoomService.searchByAccommid(accommId);
    	Accommodation accommodation = accommodationService.selectAccommodation(accommId);
    	List<Review> review = reviewService.reviewAccommList(accommId);
    	
    	model.addAttribute("roomList", roomList);
    	model.addAttribute("accommodation", accommodation);
    	model.addAttribute("review", review);
    	
    	System.out.println("accommId = " + accommId);
    	System.out.println("숙소 = " + accommodation.getAccomName());
    	System.out.println("객실 수 = " + roomList.size());
    	
    	return "/accomm/accommDetail";
    }
    
    @PostMapping("/accommDetail/calculatePrice")
    @ResponseBody
    public RoomPriceResult calculateRoomPrice(@RequestBody RoomPriceRequest req) {
        System.out.println(">> checkIn: " + req.getCheckIn());  // 👈 확인
        System.out.println(">> checkOut: " + req.getCheckOut());
        return accommodationRoomPriceService.calculateTotalPrice(req.getRoomId(), req.getCheckIn(), req.getCheckOut());
    }
    
    @PostMapping("/accommDetail/availableRooms")
    @ResponseBody
    public List<AccommodationRoom> getAvailableRooms(@RequestBody RoomAvailabilityRequest req) {
    	
    	return accommodationRoomService.getAvailableRoomsByDate(
            req.getAccommId(),
            req.getCheckIn(),
            req.getCheckOut()
        );
    }
 
    @PostMapping("/accomm/reservation")
    public String accommReservation(
            @RequestParam("roomId") String roomId,
            @RequestParam("checkIn") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate checkIn,
            @RequestParam("checkOut") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate checkOut,
            Model model, HttpServletRequest request) {

    	String userId = (String) request.getSession().getAttribute("userId");
        if (userId == null) {
            // 로그인 안 되어 있으면 로그인 페이지로 리다이렉트
            return "redirect:/user/login"; // 로그인 페이지 경로에 맞게 수정
        }
        RoomPriceResult result = accommodationRoomPriceService.calculateTotalPrice(roomId, checkIn.toString(), checkOut.toString());
        List<UserCoupon> couponList = userCouponService.getUserCouponList(userId);
        AccommodationRoom room = accommodationRoomService.searchByAccommRoomId(roomId);
        
        model.addAttribute("couponList", couponList);
        model.addAttribute("room", room);
        model.addAttribute("checkIn", checkIn);
        model.addAttribute("checkOut", checkOut);
        model.addAttribute("days", result.getDays());
        model.addAttribute("totalPrice", result.getTotalPrice());

        return "/accomm/reservation"; 
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // 숙박 동기화류는 정지해두겠습니다.
//    @GetMapping("/syncAccommodation")
//    public String syncAccommodation() {
//        try {
//            accommodationService.syncAllAccommodations();  // 전체 시군구별 숙박 동기화 실행
//            return "전체 숙박 동기화 완료.";
//        } catch (Exception e) {
//            e.printStackTrace();
//            return "에러 발생: " + e.getMessage();
//        }
//    }
//    
//    @GetMapping("/syncAccommodationDescription")
//    public String syncAccommodationDescription() {
//    	try {
//    		int count = 0;
//    		List<String> accommIdList = accommodationService.getAllAccommIds();
//    		if (accommIdList == null) {
//                return "숙소 ID 리스트가 null 입니다.";
//            }
//            if (accommIdList.isEmpty()) {
//                return "숙소 ID 리스트가 비어있습니다.";
//            }
//            for(String accommId : accommIdList) {
//            	if(accommId == null) {
//            		return "숙소 ID NULL 발생";
//            	}
//            	accommodationService.updateAccommodationDescription(accommodationService.fetchAccommodationDescription(accommId));
//            	count++;
//            }
//            return "숙소 설명 update 건수 : " + count;
//    	} catch(Exception e) {
//    		e.printStackTrace();
//    		return "에러 발생 : " + e.getMessage();
//    	}
//    	
//    }
}

