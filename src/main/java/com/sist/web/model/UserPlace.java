package com.sist.web.model;

import java.io.Serializable;

public class UserPlace implements Serializable{
	   /**
	 * 
	 */
	private static final long serialVersionUID = -2283545315865802433L;
	private String placeId;
	    private String placeName;
	    private String lat;
	    private String lon;
	    private String userId;
	    
	    public UserPlace()
	    {
	    	placeId = "";
		    placeName = "";
		    lat = "";
		    lon = "";
		    userId = "";
	    }
	    public UserPlace(String placeId, String placeName, String lat, String lon, String userId) {
	        this.placeId = placeId;
	        this.placeName = placeName;
	        this.lat = lat;
	        this.lon = lon;
	        this.userId = userId;
	    }
		public String getPlaceId() {
			return placeId;
		}

		public void setPlaceId(String placeId) {
			this.placeId = placeId;
		}

		public String getPlaceName() {
			return placeName;
		}

		public void setPlaceName(String placeName) {
			this.placeName = placeName;
		}

		public String getLat() {
			return lat;
		}

		public void setLat(String lat) {
			this.lat = lat;
		}

		public String getLon() {
			return lon;
		}

		public void setLon(String lon) {
			this.lon = lon;
		}

		public String getUserId() {
			return userId;
		}

		public void setUserId(String userId) {
			this.userId = userId;
		}
	    
	    

}
