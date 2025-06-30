package com.sist.web.dao;

import java.util.List;

import com.sist.web.model.Accommodation;
import com.sist.web.model.Sigungu;

public interface AccommodationDao {
    void insertAccommodation(Accommodation accom);
    List<Accommodation> getAllAccommodations();  // 예시용
    void updateAccommodationDescription(Accommodation accomm);
    List<Accommodation> searchBySigungu(List<Sigungu> list);
}
