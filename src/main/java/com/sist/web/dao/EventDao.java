package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Event;

@Repository("eventDao")
public interface EventDao {
	
	public Event selectEventById(String eventId);
	
	List<Event> selectActiveEvents();
    List<Event> selectEndedEvents();
    
    int countEvent();
	
    void increaseEventCount(String eventId);
}
