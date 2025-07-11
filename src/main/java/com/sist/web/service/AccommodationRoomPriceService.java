package com.sist.web.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.AccommodationRoomDao;
import com.sist.web.dao.AccommodationRoomPriceDao;
import com.sist.web.model.AccommodationRoom;
import com.sist.web.model.AccommodationRoomPrice;
import com.sist.web.model.RoomPriceResult;

@Service
public class AccommodationRoomPriceService {
	@Autowired
	private AccommodationRoomPriceDao accommodationRoomPriceDao;
	
	@Autowired
	private AccommodationRoomDao accommodationRoomDao;
	
	
	// 오류 방지를 위해 주석처리해놓음(코드로 insert문의 잔재)
//	public void insertAllRoomPrice() {
//		List<AccommodationRoom> list = accommodationRoomDao.getAllAccommodationRooms();
//		AccommodationRoomPrice roomPrice = null;
//		for(AccommodationRoom room : list) {		
//			String id = room.getAccommRoomId(); 
//			int price = Integer.parseInt(room.getStandardPrice());
//			roomPrice = new AccommodationRoomPrice(id, id, price, price, price, price);
//			accommodationRoomPriceDao.insertAccommodationRoomPrice(roomPrice);
//		}
//	}
	
	// 금액(기간에따라) 가져오기
	AccommodationRoomPrice selectAccommodationRoomPrice(Map<String, Object> param) {
		AccommodationRoomPrice roomPrice = accommodationRoomPriceDao.selectAccommodationRoomPrice(param);
		return roomPrice;
	}
	 public RoomPriceResult calculateTotalPrice(String roomId, String checkInStr, String checkOutStr) {
	        LocalDate checkIn = LocalDate.parse(checkInStr);
	        LocalDate checkOut = LocalDate.parse(checkOutStr);
	        int days = 0;
	        long totalPrice = 0;

	        LocalDate current = checkIn;
	        while (current.isBefore(checkOut)) {
	            days++;

	            Map<String, Object> param = new HashMap<>();
	            param.put("roomId", roomId);
	            param.put("targetDate", current.toString());

	            // ✅ 너가 만든 AccommodationRoomPrice 사용
	            AccommodationRoomPrice priceData = accommodationRoomPriceDao.selectAccommodationRoomPrice(param);
	            long dailyPrice = 0;

	            if (priceData != null) {
	                DayOfWeek day = current.getDayOfWeek();
	                switch (day) {
	                    case FRIDAY:
	                        dailyPrice = priceData.getAccommRoomPriceFriday();
	                        break;
	                    case SATURDAY:
	                        dailyPrice = priceData.getAccommRoomPriceSaturday();
	                        break;
	                    case SUNDAY:
	                        dailyPrice = priceData.getAccommRoomPriceSunday();
	                        break;
	                    default:
	                        dailyPrice = priceData.getAccommRoomPriceWeekday();
	                        break;
	                }
	            } else {
	                // 가격 정책이 없을 경우 기본 standardPrice 사용
	                int standardPrice =10;
	                dailyPrice = standardPrice;
	            }

	            totalPrice += dailyPrice;
	            current = current.plusDays(1);
	        }

	        RoomPriceResult result = new RoomPriceResult();
	        result.setDays(days);
	        result.setTotalPrice(totalPrice);
	        return result;
	    }
}
