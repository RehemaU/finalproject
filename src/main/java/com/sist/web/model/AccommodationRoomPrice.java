package com.sist.web.model;

public class AccommodationRoomPrice {
    private String accommRoomPriceId;
    private String accommRoomId;
    private String accommRoomPriceStart;
    private String accommRoomPriceEnd;
    private int accommRoomPriceWeekday;
    private int accommRoomPriceFriday;
    private int accommRoomPriceSaturday;
    private int accommRoomPriceSunday;

    public String getAccommRoomPriceId() {
		return accommRoomPriceId;
	}

	public void setAccommRoomPriceId(String accommRoomPriceId) {
		this.accommRoomPriceId = accommRoomPriceId;
	}

	public String getAccommRoomId() {
		return accommRoomId;
	}

	public void setAccommRoomId(String accommRoomId) {
		this.accommRoomId = accommRoomId;
	}

	public String getAccommRoomPriceStart() {
		return accommRoomPriceStart;
	}

	public void setAccommRoomPriceStart(String accommRoomPriceStart) {
		this.accommRoomPriceStart = accommRoomPriceStart;
	}

	public String getAccommRoomPriceEnd() {
		return accommRoomPriceEnd;
	}

	public void setAccommRoomPriceEnd(String accommRoomPriceEnd) {
		this.accommRoomPriceEnd = accommRoomPriceEnd;
	}

	public int getAccommRoomPriceWeekday() {
		return accommRoomPriceWeekday;
	}

	public void setAccommRoomPriceWeekday(int accommRoomPriceWeekday) {
		this.accommRoomPriceWeekday = accommRoomPriceWeekday;
	}

	public int getAccommRoomPriceFriday() {
		return accommRoomPriceFriday;
	}

	public void setAccommRoomPriceFriday(int accommRoomPriceFriday) {
		this.accommRoomPriceFriday = accommRoomPriceFriday;
	}

	public int getAccommRoomPriceSaturday() {
		return accommRoomPriceSaturday;
	}

	public void setAccommRoomPriceSaturday(int accommRoomPriceSaturday) {
		this.accommRoomPriceSaturday = accommRoomPriceSaturday;
	}

	public int getAccommRoomPriceSunday() {
		return accommRoomPriceSunday;
	}

	public void setAccommRoomPriceSunday(int accommRoomPriceSunday) {
		this.accommRoomPriceSunday = accommRoomPriceSunday;
	}

	public AccommodationRoomPrice(String accommRoomPriceId, String accommRoomId, String accommRoomPriceStart,
                                   String accommRoomPriceEnd, int accommRoomPriceWeekday, int accommRoomPriceFriday,
                                   int accommRoomPriceSaturday, int accommRoomPriceSunday) {
        this.accommRoomPriceId = accommRoomPriceId;
        this.accommRoomId = accommRoomId;
        this.accommRoomPriceStart = accommRoomPriceStart;
        this.accommRoomPriceEnd = accommRoomPriceEnd;
        this.accommRoomPriceWeekday = accommRoomPriceWeekday;
        this.accommRoomPriceFriday = accommRoomPriceFriday;
        this.accommRoomPriceSaturday = accommRoomPriceSaturday;
        this.accommRoomPriceSunday = accommRoomPriceSunday;
    }
}
	