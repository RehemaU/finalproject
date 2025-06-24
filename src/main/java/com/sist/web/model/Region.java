package com.sist.web.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Region {
	@JsonProperty("code")
	private String regionId;
	
	@JsonProperty("name")
    private String regionName;  // REGION_NAME
    private String regionLat;   // REGION_LAT
    private String regionLon;   // REGION_LON


    public Region() {}


    public Region(String regionId, String regionName, String regionLat, String regionLon) {
        this.regionId = regionId;
        this.regionName = regionName;
        this.regionLat = regionLat;
        this.regionLon = regionLon;
    }

    public String getRegionId() {
        return regionId;
    }

    public void setRegionId(String regionId) {
        this.regionId = regionId;
    }

    public String getRegionName() {
        return regionName;
    }

    public void setRegionName(String regionName) {
        this.regionName = regionName;
    }

    public String getRegionLat() {
        return regionLat;
    }

    public void setRegionLat(String regionLat) {
        this.regionLat = regionLat;
    }

    public String getRegionLon() {
        return regionLon;
    }

    public void setRegionLon(String regionLon) {
        this.regionLon = regionLon;
    }
}
