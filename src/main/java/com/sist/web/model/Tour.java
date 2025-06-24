package com.sist.web.model;

public class Tour {
    private String tourId;
    private String unifiedId;
    private String regionId;
    private String tourName;
    private double tourLat;
    private double tourLon;
    private String tourAdd;
    private String tourDes;

    // 기본 생성자
    public Tour() {}

    // 전체 필드 포함 생성자
    public Tour(String tourId, String unifiedId, String regionId, String tourName,
                double tourLat, double tourLon, String tourAdd, String tourDes) {
        this.tourId = tourId;
        this.unifiedId = unifiedId;
        this.regionId = regionId;
        this.tourName = tourName;
        this.tourLat = tourLat;
        this.tourLon = tourLon;
        this.tourAdd = tourAdd;
        this.tourDes = tourDes;
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

    
}
