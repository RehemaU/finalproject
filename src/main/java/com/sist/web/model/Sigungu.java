package com.sist.web.model;

public class Sigungu {
    private String regionId;    // 시도 코드
    private String sigunguId;   // 시군구 코드
    private String sigunguName; // 시군구 이름
    private String sigunguLat;  // 위도
    private String sigunguLon;  // 경도

    public Sigungu() {}

    public Sigungu(String regionId, String sigunguId, String sigunguName, String sigunguLat, String sigunguLon) {
        this.regionId = regionId;
        this.sigunguId = sigunguId;
        this.sigunguName = sigunguName;
        this.sigunguLat = sigunguLat;
        this.sigunguLon = sigunguLon;
    }

    public String getRegionId() {
        return regionId;
    }

    public void setRegionId(String regionId) {
        this.regionId = regionId;
    }

    public String getSigunguId() {
        return sigunguId;
    }

    public void setSigunguId(String sigunguId) {
        this.sigunguId = sigunguId;
    }

    public String getSigunguName() {
        return sigunguName;
    }

    public void setSigunguName(String sigunguName) {
        this.sigunguName = sigunguName;
    }

    public String getSigunguLat() {
        return sigunguLat;
    }

    public void setSigunguLat(String sigunguLat) {
        this.sigunguLat = sigunguLat;
    }

    public String getSigunguLon() {
        return sigunguLon;
    }

    public void setSigunguLon(String sigunguLon) {
        this.sigunguLon = sigunguLon;
    }

    @Override
    public String toString() {
        return "Sigungu{" +
                "regionId='" + regionId + '\'' +
                ", sigunguId='" + sigunguId + '\'' +
                ", sigunguName='" + sigunguName + '\'' +
                ", sigunguLat='" + sigunguLat + '\'' +
                ", sigunguLon='" + sigunguLon + '\'' +
                '}';
    }
}
