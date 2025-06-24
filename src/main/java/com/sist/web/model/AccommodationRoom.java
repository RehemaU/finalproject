package com.sist.web.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class AccommodationRoom {

    @JsonProperty("roomcode")
    private String accommRoomId;        // 객실 고유 ID (서브 컨텐츠 ID)

    @JsonProperty("contentid")
    private String accommId;            // 숙소 ID (Accommodation ID)

    @JsonProperty("roomtitle")
    private String roomName;           // 객실 이름

    @JsonProperty("roomsize1")
    private String roomScale;          // 객실 크기 (평수 등)

    @JsonProperty("roomcount")
    private String roomCount;          // 객실 개수

    @JsonProperty("roombasecount")
    private String standardPerson;     // 기준 인원

    @JsonProperty("roombathfacility")
    private String bathroom;           // 욕실 시설 여부

    @JsonProperty("roombath")
    private String bath;               // 욕조 여부

    @JsonProperty("roomtv")
    private String tv;                 // TV 여부

    @JsonProperty("roompc")
    private String pc;                 // PC 여부

    @JsonProperty("roominternet")
    private String internet;           // 인터넷 여부

    @JsonProperty("roomrefrigerator")
    private String refrigerator;      // 냉장고 여부

    @JsonProperty("roomsofa")
    private String sofa;               // 소파 여부

    @JsonProperty("roomtable")
    private String table;              // 테이블 여부

    @JsonProperty("roomhairdryer")
    private String dryer;              // 헤어드라이어 여부

    @JsonProperty("checkintime")
    private String checkIn;            // 체크인 시간 (API에 없으면 null 가능)

    @JsonProperty("checkouttime")
    private String checkOut;           // 체크아웃 시간 (API에 없으면 null 가능)

    @JsonProperty("roomoffseasonminfee1")
    private String standardPrice;      // 객실 기본 요금 (비수기 최소 요금)

    // 기본 생성자
    public AccommodationRoom() {}

    // getters and setters

    public String getAccommRoomId() {
        return accommRoomId;
    }

    public void setAccommRoomId(String accommRoomId) {
        this.accommRoomId = accommRoomId;
    }

    public String getAccommId() {
        return accommId;
    }

    public void setAccommId(String accommId) {
        this.accommId = accommId;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getRoomScale() {
        return roomScale;
    }

    public void setRoomScale(String roomScale) {
        this.roomScale = roomScale;
    }

    public String getRoomCount() {
        return roomCount;
    }

    public void setRoomCount(String roomCount) {
        this.roomCount = roomCount;
    }

    public String getStandardPerson() {
        return standardPerson;
    }

    public void setStandardPerson(String standardPerson) {
        this.standardPerson = standardPerson;
    }

    public String getBathroom() {
        return bathroom;
    }

    public void setBathroom(String bathroom) {
        this.bathroom = bathroom;
    }

    public String getBath() {
        return bath;
    }

    public void setBath(String bath) {
        this.bath = bath;
    }

    public String getTv() {
        return tv;
    }

    public void setTv(String tv) {
        this.tv = tv;
    }

    public String getPc() {
        return pc;
    }

    public void setPc(String pc) {
        this.pc = pc;
    }

    public String getInternet() {
        return internet;
    }

    public void setInternet(String internet) {
        this.internet = internet;
    }

    public String getRefrigerator() {
        return refrigerator;
    }

    public void setRefrigerator(String refrigerator) {
        this.refrigerator = refrigerator;
    }

    public String getSofa() {
        return sofa;
    }

    public void setSofa(String sofa) {
        this.sofa = sofa;
    }

    public String getTable() {
        return table;
    }

    public void setTable(String table) {
        this.table = table;
    }

    public String getDryer() {
        return dryer;
    }

    public void setDryer(String dryer) {
        this.dryer = dryer;
    }

    public String getCheckIn() {
        return checkIn;
    }

    public void setCheckIn(String checkIn) {
        this.checkIn = checkIn;
    }

    public String getCheckOut() {
        return checkOut;
    }

    public void setCheckOut(String checkOut) {
        this.checkOut = checkOut;
    }

    public String getStandardPrice() {
        return standardPrice;
    }

    public void setStandardPrice(String standardPrice) {
        this.standardPrice = standardPrice;
    }
}
