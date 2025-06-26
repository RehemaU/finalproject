package com.sist.web.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Tour {

    @JsonProperty("contentid")
    private String tourId;

    private String unifiedId; // 내부 로직에서 별도 세팅 또는 DB 키 등

    @JsonProperty("areacode")
    private String regionId;

    @JsonProperty("title")
    private String tourName;

    @JsonProperty("mapy")
    private double tourLat;

    @JsonProperty("mapx")
    private double tourLon;

    @JsonProperty("addr1")
    private String tourAdd;

    @JsonProperty("overview")
    private String tourDes;

    @JsonProperty("sigungucode")
    private String sigunguId;
    
    @JsonProperty("firstImage")
    private String tourImage;
    
    public String getTourImage() {
		return tourImage;
	}

	public void setTourImage(String tourImage) {
		this.tourImage = tourImage;
	}

	public Tour() {}

    public Tour(String tourId, String unifiedId, String regionId, String tourName,
                double tourLat, double tourLon, String tourAdd, String tourDes, String sigunguId) {
        this.tourId = tourId;
        this.unifiedId = unifiedId;
        this.regionId = regionId;
        this.tourName = tourName;
        this.tourLat = tourLat;
        this.tourLon = tourLon;
        this.tourAdd = tourAdd;
        this.tourDes = tourDes;
        this.sigunguId = sigunguId;
    }

    public String getTourId() {
        return tourId;
    }

    public void setTourId(String tourId) {
        this.tourId = tourId;
    }

    public String getUnifiedId() {
        return unifiedId;
    }

    public void setUnifiedId(String unifiedId) {
        this.unifiedId = unifiedId;
    }

    public String getRegionId() {
        return regionId;
    }

    public void setRegionId(String regionId) {
        this.regionId = regionId;
    }

    public String getTourName() {
        return tourName;
    }

    public void setTourName(String tourName) {
        this.tourName = tourName;
    }

    public double getTourLat() {
        return tourLat;
    }

    public void setTourLat(double tourLat) {
        this.tourLat = tourLat;
    }

    public double getTourLon() {
        return tourLon;
    }

    public void setTourLon(double tourLon) {
        this.tourLon = tourLon;
    }

    public String getTourAdd() {
        return tourAdd;
    }

    public void setTourAdd(String tourAdd) {
        this.tourAdd = tourAdd;
    }

    public String getTourDes() {
        return tourDes;
    }

    public void setTourDes(String tourDes) {
        this.tourDes = tourDes;
    }

    public String getSigunguId() {
        return sigunguId;
    }

    public void setSigunguId(String sigunguId) {
        this.sigunguId = sigunguId;
    }
}