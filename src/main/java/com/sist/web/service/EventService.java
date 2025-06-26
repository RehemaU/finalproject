package com.sist.web.service;

import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.EventDao;


@Service("eventService")
public class EventService {
	private static final Logger logger = LoggerFactory.getLogger(EventService.class);
	
	@Autowired
	private EventDao eventDao;
	
	
	
}
