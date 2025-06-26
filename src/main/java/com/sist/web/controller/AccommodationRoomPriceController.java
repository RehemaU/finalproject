package com.sist.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.sist.web.model.AccommodationRoom;
import com.sist.web.service.AccommodationRoomPriceService;
import com.sist.web.service.AccommodationRoomService;

import java.util.List;

@RestController
@RequestMapping("/admin")
public class AccommodationRoomPriceController {

    @Autowired
    private AccommodationRoomPriceService accommodationRoomPriceService;

    @GetMapping("/syncRoomPrice")
    public String RoomPrice() {
        int totalCount = 0;
        try {
        	accommodationRoomPriceService.insertAllRoomPrice();
        	return "객실 가격 동기화 완료";
        } catch (Exception e) {   
            return "객실 가격 동기화 중 에러 발생: " + e.getMessage();
        }
    }

}