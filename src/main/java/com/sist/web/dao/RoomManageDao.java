package com.sist.web.dao;

import java.util.List;

import com.sist.web.model.AccommodationRoom;

public interface RoomManageDao {
    void insertRoom(AccommodationRoom room);
    List<AccommodationRoom> findByAccommId(String accommId);
    AccommodationRoom findByRoomId(String roomId);
    String getNextAccommRoomSeq();
    List<AccommodationRoom> findRoomsByAccomm(String accommId);  // ✅ 이름 맞추기

}
