package com.sist.web.model;

public class WeatherInfo {
    private String temperature;
    private String sky;
    private String rainType;

    // ✅ 추가: 요청 정보 저장용
    private double latitude;
    private double longitude;
    private String baseDate;
    private String baseTime;
    
    private String city;

    // 기존 getter/setter
    public String getTemperature() { return temperature; }
    public void setTemperature(String temperature) { this.temperature = temperature; }

    public String getSky() { return sky; }
    public void setSky(String sky) { this.sky = sky; }

    public String getRainType() { return rainType; }
    public void setRainType(String rainType) { this.rainType = rainType; }

    public String getSkyDescription() {
        switch (sky) {
            case "1": return "맑음";
            case "3": return "구름 많음";
            case "4": return "흐림";
            default: return "정보 없음";
        }
    }

    public String getRainDescription() {
        switch (rainType) {
            case "0": return "비소식 없음";
            case "1": return "비";
            case "2": return "비/눈";
            case "3": return "눈";
            case "4": return "소나기";
            default: return "정보 없음";
        }
    }

    // ✅ 추가: 위치 및 시간 getter/setter
    public double getLatitude() { return latitude; }
    public void setLatitude(double latitude) { this.latitude = latitude; }

    public double getLongitude() { return longitude; }
    public void setLongitude(double longitude) { this.longitude = longitude; }

    public String getBaseDate() { return baseDate; }
    public void setBaseDate(String baseDate) { this.baseDate = baseDate; }

    public String getBaseTime() { return baseTime; }
    public void setBaseTime(String baseTime) { this.baseTime = baseTime; }
	
    
    public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
    

}
