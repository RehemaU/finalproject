package com.sist.web.dao;

import java.util.List;

import com.sist.web.model.Accommodation;

public interface AccommodationDao {
    void insertAccommodation(Accommodation accom);
    List<Accommodation> getAllAccommodations();  // 예시용
}
