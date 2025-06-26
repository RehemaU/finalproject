package com.sist.web.dao;

import java.util.List;

import com.sist.web.model.Tour;

public interface TourDao {
	void insertTour(Tour tour);
	List<Tour> getAllTours();
}
