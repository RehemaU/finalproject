package com.sist.web.model;

import java.io.Serializable;
import java.util.Date;

public class CalanderList implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3048352542205248520L;
	private String calanderListId;
    private String userId;
    private String calanderListName;
    private Date calanderListStartDate;
    private Date calanderListEndDate;
    // Getter, Setter, Constructor
    
    
    CalanderList()
    {
    	calanderListId = "";
    	userId = "";
    	calanderListName = "";
    	calanderListStartDate = null;
    	calanderListEndDate = null;
    }

    public CalanderList(String calanderListId, String userId, String calanderListName,
            Date calanderListStartDate, Date calanderListEndDate) 
    {
		this.calanderListId = calanderListId;
		this.userId = userId;
		this.calanderListName = calanderListName;
		this.calanderListStartDate = calanderListStartDate;
		this.calanderListEndDate = calanderListEndDate;
	}
	public String getCalanderListId() {
		return calanderListId;
	}


	public void setCalanderListId(String calanderListId) {
		this.calanderListId = calanderListId;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getCalanderListName() {
		return calanderListName;
	}


	public void setCalanderListName(String calanderListName) {
		this.calanderListName = calanderListName;
	}


	public Date getCalanderListStartDate() {
		return calanderListStartDate;
	}


	public void setCalanderListStartDate(Date calanderListStartDate) {
		this.calanderListStartDate = calanderListStartDate;
	}
    
    
}

