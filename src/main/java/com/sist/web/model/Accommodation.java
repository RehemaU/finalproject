package com.sist.web.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Accommodation {

	public Accommodation() {
		
		this.unifiedId = "";
		
	}
	
    @JsonProperty("contentid")
    private String accomId;

    @JsonProperty("areacode")
    private String regionId;

    @JsonProperty("sigungucode")
    private String sigunguCode;

    @JsonProperty("zipcode")
    private String zipcode;

    private String sellerId; // 내부 로직에서 세팅
    private String accomStatus; // 기본값

    @JsonProperty("title")
    private String accomName;

    @JsonProperty("tel")
    private String accomTel;

    @JsonProperty("addr1")
    private String accomAdd;

    @JsonProperty("addr2")
    private String accomAdd2;

    @JsonProperty("overview")
    private String accomDes;

    @JsonProperty("mapy")
    private String accomLat;

    @JsonProperty("mapx")
    private String accomLon;

    @JsonProperty("firstimage")
    private String firstImage;

    @JsonProperty("firstimage2")
    private String firstImage2;
    
    private String unifiedId;
    
    private double rating;
    private int accommCount;
    
    public int getAccommCount() {
		return accommCount;
	}

	public void setAccommCount(int accommCount) {
		this.accommCount = accommCount;
	}

	public double getRating() {
		return rating;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}

	public String getUnifiedId() {
		return unifiedId;
	}

	public void setUnifiedId(String unfiedId) {
		this.unifiedId = unfiedId;
	}

	private int accomAvg;

    private boolean liked;

    public boolean isLiked() {
        return liked;
    }

    public void setLiked(boolean liked) {
        this.liked = liked;
    }
    
	public String getAccomId() {
		return accomId;
	}

	public void setAccomId(String accomId) {
		this.accomId = accomId;
	}

	public String getRegionId() {
		return regionId;
	}

	public void setRegionId(String regionId) {
		this.regionId = regionId;
	}

	public String getSigunguCode() {
		return sigunguCode;
	}

	public void setSigunguCode(String sigunguCode) {
		this.sigunguCode = sigunguCode;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getSellerId() {
		return sellerId;
	}

	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}

	public String getAccomStatus() {
		return accomStatus;
	}

	public void setAccomStatus(String accomStatus) {
		this.accomStatus = accomStatus;
	}

	public String getAccomName() {
		return accomName;
	}

	public void setAccomName(String accomName) {
		this.accomName = accomName;
	}

	public String getAccomTel() {
		return accomTel;
	}

	public void setAccomTel(String accomTel) {
		this.accomTel = accomTel;
	}

	public String getAccomAdd() {
		return accomAdd;
	}

	public void setAccomAdd(String accomAdd) {
		this.accomAdd = accomAdd;
	}

	public String getAccomAdd2() {
		return accomAdd2;
	}

	public void setAccomAdd2(String accomAdd2) {
		this.accomAdd2 = accomAdd2;
	}

	public String getAccomDes() {
		return accomDes;
	}

	public void setAccomDes(String accomDes) {
		this.accomDes = accomDes;
	}

	public String getAccomLat() {
		return accomLat;
	}

	public void setAccomLat(String accomLat) {
		this.accomLat = accomLat;
	}

	public String getAccomLon() {
		return accomLon;
	}

	public void setAccomLon(String accomLon) {
		this.accomLon = accomLon;
	}

	public String getFirstImage() {
		return firstImage;
	}

	public void setFirstImage(String firstImage) {
		this.firstImage = firstImage;
	}

	public String getFirstImage2() {
		return firstImage2;
	}

	public void setFirstImage2(String firstImage2) {
		this.firstImage2 = firstImage2;
	}

	public int getAccomAvg() {
		return accomAvg;
	}

	public void setAccomAvg(int accomAvg) {
		this.accomAvg = accomAvg;
	}
    
    

}
