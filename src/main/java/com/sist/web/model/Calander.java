package com.sist.web.model;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Calander implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2496973534779212869L;
	 private String calanderId;
	    private String calanderListId;
	    private String spotId; // 숙소든 관광지든 통합 장소 ID
	    private String calanderStartTime;
	    private String calanderEndTime;
	    private String locationName;
	    private String lat;
	    private String lon;


	    // 기본 생성자
	    public Calander() {
	        this.calanderId = "";
	        this.calanderListId = "";
	        this.spotId = "";
	        this.calanderStartTime = "";
	        this.calanderEndTime = "";
	    }

	    // ✅ Date 타입을 받는 생성자 추가 (SimpleDateFormat으로 변환)
	    public Calander(String calanderId, String calanderListId, String spotId, Date startTime, Date endTime) {
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        this.calanderId = calanderId;
	        this.calanderListId = calanderListId;
	        this.spotId = spotId;
	        this.calanderStartTime = sdf.format(startTime);
	        this.calanderEndTime = sdf.format(endTime);
	    }
	    public String getLat() {
	        return lat;
	    }
	    public void setLat(String lat) {
	        this.lat = lat;
	    }
	    public String getLon() {
	        return lon;
	    }
	    public void setLon(String lon) {
	        this.lon = lon;
	    }
	    // locationName (JOIN된 장소 이름)
	    public String getLocationName() {
	        return locationName;
	    }

	    public void setLocationName(String locationName) {
	        this.locationName = locationName;
	    }

	    // Getters & Setters
	    public String getCalanderId() {
	        return calanderId;
	    }

	    public void setCalanderId(String calanderId) {
	        this.calanderId = calanderId;
	    }

	    public String getCalanderListId() {
	        return calanderListId;
	    }

	    public void setCalanderListId(String calanderListId) {
	        this.calanderListId = calanderListId;
	    }

	    public String getSpotId() {
	        return spotId;
	    }

	    public void setSpotId(String spotId) {
	        this.spotId = spotId;
	    }

	    public String getCalanderStartTime() {
	        return calanderStartTime;
	    }

	    public void setCalanderStartTime(String calanderStartTime) {
	        this.calanderStartTime = calanderStartTime;
	    }

	    public String getCalanderEndTime() {
	        return calanderEndTime;
	    }

	    public void setCalanderEndTime(String calanderEndTime) {
	        this.calanderEndTime = calanderEndTime;
	    }
	}

