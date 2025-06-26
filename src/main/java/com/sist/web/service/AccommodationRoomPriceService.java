package com.sist.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.AccommodationRoomDao;
import com.sist.web.dao.AccommodationRoomPriceDao;
import com.sist.web.model.AccommodationRoom;
import com.sist.web.model.AccommodationRoomPrice;

@Service
public class AccommodationRoomPriceService {
	@Autowired
	private AccommodationRoomPriceDao accommodationRoomPriceDao;
	
	@Autowired
	private AccommodationRoomDao accommodationRoomDao;
	
	
	
	public void insertAllRoomPrice() {
		List<AccommodationRoom> list = accommodationRoomDao.getAllAccommodationRooms();
		AccommodationRoomPrice roomPrice = null;
		for(AccommodationRoom room : list) {		
			String id = room.getAccommRoomId(); 
			int price = Integer.parseInt(room.getStandardPrice());
			roomPrice = new AccommodationRoomPrice(id, id, price, price, price, price);
			accommodationRoomPriceDao.insertAccommodationRoomPrice(roomPrice);
		}
	}
}
