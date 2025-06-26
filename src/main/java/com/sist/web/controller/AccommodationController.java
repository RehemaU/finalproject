package com.sist.web.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.sist.web.model.Accommodation;
import com.sist.web.service.AccommodationService;

import java.util.List;

@RestController
@RequestMapping("/admin")
public class AccommodationController {

    @Autowired
    private AccommodationService accommodationService;

    @GetMapping("/syncAccommodation")
    public String syncAccommodation() {
        int totalCount = 0;
        try {
            for (int page = 3901; page <= 3904; page++) { 
                List<Accommodation> list = accommodationService.fetchAccommodation(1, 20,"" + page);
                accommodationService.saveAccommodationList(list);
                totalCount += list.size();
            }
            return "동기화 완료: " + totalCount + "건 저장됨.";
        } catch (Exception e) {
            e.printStackTrace();
            return "에러 발생: " + e.getMessage();
        }
    }
 // 📍 숙소 전체 리스트를 JSON 형태로 반환 (마커용)
    @GetMapping("/accommodation/listAll")
    public List<Accommodation> getAllAccommodations() {
        return accommodationService.getAllAccommodations(); // DB에서 전체 숙소 조회
    }
}
