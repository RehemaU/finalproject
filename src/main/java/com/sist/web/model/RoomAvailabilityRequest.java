package com.sist.web.model;

public class RoomAvailabilityRequest {
    private String accommId;
    private String checkIn;   // YYYY-MM-DD
    private String checkOut;  // YYYY-MM-DD

    public String getAccommId() {
        return accommId;
    }

    public void setAccommId(String accommId) {
        this.accommId = accommId;
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

    @Override
    public String toString() {
        return "RoomAvailabilityRequest{" +
                "accommId='" + accommId + '\'' +
                ", checkIn='" + checkIn + '\'' +
                ", checkOut='" + checkOut + '\'' +
                '}';
    }
}
