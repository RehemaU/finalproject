package com.sist.web.dao;

import java.util.List;

import com.sist.web.model.Sigungu;
import com.sist.web.model.Tour;

public interface TourDao {
	void insertTour(Tour tour);
	List<Tour> searchBySigungu(List<Sigungu> list);
}
