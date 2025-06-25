package com.sist.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.sist.web.service.TourService;

@RestController
@RequestMapping("/admin")
public class TourController {

    @Autowired
    private TourService tourService;

    @GetMapping("/syncTour")
    public String syncTour() {
        try {
            tourService.syncAllTours();  // 전체 시군구별 관광지 동기화 실행
            return "전체 관광지 동기화 완료.";
        } catch (Exception e) {
            e.printStackTrace();
            return "에러 발생: " + e.getMessage();
        }
    }
}
