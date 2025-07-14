package com.sist.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.RoomManageDao;
import com.sist.web.model.AccommodationRoom;

@Service
public class RoomManageService {
	   @Autowired
	    private RoomManageDao roomManageDao;

	    
	    public void insertRoom(AccommodationRoom room) {
	        String nextSeq = roomManageDao.getNextAccommRoomSeq();
	        room.setAccommRoomId("ROOM_" + nextSeq);
	        roomManageDao.insertRoom(room);
	    }

	    
	    public List<AccommodationRoom> findRoomsByAccomm(String accommId) {
	        return roomManageDao.findRoomsByAccomm(accommId);  // ✅ 메서드명 변경
	    }

	    
	    public AccommodationRoom getRoom(String roomId) {
	        return roomManageDao.findByRoomId(roomId);
	    }
}
