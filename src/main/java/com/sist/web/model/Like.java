package com.sist.web.model;

import java.io.Serializable;

public class Like implements Serializable{
	
	private static final long serialVersionUID = 6338014171269162979L;

	    private String likeId;
	    private String userId;
	    private String spotId; // tourId가 들어갈 필드
	    private String tourName;    // JOIN된 T_SPOT의 컬럼
	    private String tourImage;
	    private String tourAdd;
	    
	    // 숙소용
	    private String accomName;
	    private String firstImage;
	    private String accomAdd;
	    // 생성자
	    public Like() {}
	    
	    public Like(String userId, String spotId) {
	        this.userId = userId;
	        this.spotId = spotId;
//	        this.tourName = tourName;
//	        this.tourImage = tourImage;
//	        this.tourAdd = tourAdd;
	    }
	    
	    public String getAccomName() {
			return accomName;
		}

		public void setAccomName(String accomName) {
			this.accomName = accomName;
		}

		public String getFirstImage() {
			return firstImage;
		}

		public void setFirstImage(String firstImage) {
			this.firstImage = firstImage;
		}

		public String getAccomAdd() {
			return accomAdd;
		}

		public void setAccomAdd(String accomAdd) {
			this.accomAdd = accomAdd;
		}

		public String getTourName() { return tourName; }
	    public void setTourName(String tourName) { this.tourName = tourName; }

	    public String getTourImage() { return tourImage; }
	    public void setTourImage(String tourImage) { this.tourImage = tourImage; }

	    public String getTourAdd() { return tourAdd; }
	    public void setTourAdd(String tourAdd) { this.tourAdd = tourAdd; }
	    // Getter & Setter
	    public String getLikeId() { return likeId; }
	    public void setLikeId(String likeId) { this.likeId = likeId; }
	    
	    public String getUserId() { return userId; }
	    public void setUserId(String userId) { this.userId = userId; }
	    
	    public String getSpotId() { return spotId; }
	    public void setSpotId(String spotId) { this.spotId = spotId; }
	}