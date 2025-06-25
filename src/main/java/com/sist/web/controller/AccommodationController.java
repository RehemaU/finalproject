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
        try {
            accommodationService.syncAllAccommodations();  // 전체 시군구별 숙박 동기화 실행
            return "전체 숙박 동기화 완료.";
        } catch (Exception e) {
            e.printStackTrace();
            return "에러 발생: " + e.getMessage();
        }
    }
    
    @GetMapping("/syncAccommodationDescription")
    public String syncAccommodationDescription() {
    	try {
    		int count = 0;
    		List<String> accommIdList = accommodationService.getAllAccommIds();
    		if (accommIdList == null) {
                return "숙소 ID 리스트가 null 입니다.";
            }
            if (accommIdList.isEmpty()) {
                return "숙소 ID 리스트가 비어있습니다.";
            }
            for(String accommId : accommIdList) {
            	if(accommId == null) {
            		return "숙소 ID NULL 발생";
            	}
            	accommodationService.updateAccommodationDescription(accommodationService.fetchAccommodationDescription(accommId));
            	count++;
            }
            return "숙소 설명 update 건수 : " + count;
    	} catch(Exception e) {
    		e.printStackTrace();
    		return "에러 발생 : " + e.getMessage();
    	}
    	
    }
}

