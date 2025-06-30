package com.sist.web.model;

import java.io.Serializable;

public class Event implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3524449004151512915L;
	
	private String eventId;
    private String adminId;
    private String couponId;
    private String eventTitle;
    private String eventContent;
    private String eventRegdate;
    private String eventEnddate;
    private int eventCount;
    private String eventThumbnailUrl;
    private String eventImageUrl;
    

    public Event() 
    {
        this.eventId = "";
        this.adminId = "";
        this.couponId = "";
        this.eventTitle = "";
        this.eventContent = "";
        this.eventRegdate = ""; // DB에서 SYSDATE로 처리할 경우 null 허용
        this.eventCount = 0;
        this.eventEnddate = "";
        this.eventThumbnailUrl = "";
        this.eventImageUrl = "";
        
    }

    
    
	public String getEventImageUrl() {
		return eventImageUrl;
	}



	public void setEventImageUrl(String eventImageUrl) {
		this.eventImageUrl = eventImageUrl;
	}



	public String getEventEnddate() {
		return eventEnddate;
	}



	public void setEventEnddate(String eventEnddate) {
		this.eventEnddate = eventEnddate;
	}



	public String getEventThumbnailUrl() {
		return eventThumbnailUrl;
	}



	public void setEventThumbnailUrl(String eventThumbnailUrl) {
		this.eventThumbnailUrl = eventThumbnailUrl;
	}



	public String getEventId() {
		return eventId;
	}

	public void setEventId(String eventId) {
		this.eventId = eventId;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getCouponId() {
		return couponId;
	}

	public void setCouponId(String couponId) {
		this.couponId = couponId;
	}

	public String getEventTitle() {
		return eventTitle;
	}

	public void setEventTitle(String eventTitle) {
		this.eventTitle = eventTitle;
	}

	public String getEventContent() {
		return eventContent;
	}

	public void setEventContent(String eventContent) {
		this.eventContent = eventContent;
	}

	public String getEventRegdate() {
		return eventRegdate;
	}

	public void setEventRegdate(String eventRegdate) {
		this.eventRegdate = eventRegdate;
	}

	public int getEventCount() {
		return eventCount;
	}

	public void setEventCount(int eventCount) {
		this.eventCount = eventCount;
	}

	
	
	
}
