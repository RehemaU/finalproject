package com.sist.web.dao;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Event;

@Repository("eventDao")
public interface EventDao {
	
	public Event selectEventById(String userId);
}
