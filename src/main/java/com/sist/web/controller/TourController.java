package com.sist.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.sist.web.model.Tour;
import com.sist.web.model.Accommodation;
import com.sist.web.model.Region;
import com.sist.web.model.Sigungu;
import com.sist.web.model.Tour;
import com.sist.web.service.RegionService;
import com.sist.web.service.SigunguService;
import com.sist.web.service.TourService;

@Controller("TourController")
public class TourController {

    @Autowired
    private TourService tourService;
    
    @Autowired
    private SigunguService sigunguService;
    
    @Autowired
    private RegionService regionService;
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

    @GetMapping("/listAll")
    @ResponseBody
    public List<Tour> getAllTours() {
        return tourService.getAllTours();
    }
    

    
    @GetMapping("/tour/list")
    public String listPage(Model model) {
        List<Sigungu> sigunguList = sigunguService.getAllSigungus();
        List<Region> regionList = regionService.getAllRegions();
        model.addAttribute("sigunguList", sigunguList);
        model.addAttribute("regionList", regionList);
        return "/tour/list";
    }
    
    @PostMapping("/tour/filterList")
    public String filterList(@RequestBody List<Sigungu> sigunguList, Model model) {
    	 List<Tour> results = tourService.findBySigunguList(sigunguList);
    	    model.addAttribute("results", results);
    	    System.out.println("받은 조건 개수: " + sigunguList.size());
    	    for (Sigungu s : sigunguList) {
    	        System.out.println("조건: " + s.getRegionId() + ", " + s.getSigunguId());
    	    }
    	    System.out.println("조회된 숙소 개수: " + results.size());

    	    return "/tour/cardList";
    }
}
