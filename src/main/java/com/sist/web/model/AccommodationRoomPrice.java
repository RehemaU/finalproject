package com.sist.web.model;

public class AccommodationRoomPrice {
    private String accommRoomPriceId;
    private String accommRoomId;
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

	public AccommodationRoomPrice(String accommRoomPriceId, String accommRoomId, int accommRoomPriceWeekday, int accommRoomPriceFriday,
                                   int accommRoomPriceSaturday, int accommRoomPriceSunday) {
        this.accommRoomPriceId = accommRoomPriceId;
        this.accommRoomId = accommRoomId;
        this.accommRoomPriceWeekday = accommRoomPriceWeekday;
        this.accommRoomPriceFriday = accommRoomPriceFriday;
        this.accommRoomPriceSaturday = accommRoomPriceSaturday;
        this.accommRoomPriceSunday = accommRoomPriceSunday;
    }
}
	