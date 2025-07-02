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
    
    private boolean isPlan;
    private int planId;
    
    // Getter, Setter, Constructor
    
    
    CalanderList()
    {
    	calanderListId = "";
    	userId = "";
    	calanderListName = "";
    	calanderListStartDate = null;
    	calanderListEndDate = null;
    	isPlan=false;
    	planId=0;
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

	//--
	public boolean getIsPlan() {
		return isPlan;
	}

	public void setIsPlan(boolean isPlan) {
		this.isPlan = isPlan;
	}
	
	public int getPlanId() {
		return planId;
	}
	
	public void setPlanId(int planId) {
		this.planId = planId;
	}
	//--
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

	public Date getCalanderListEndDate() {
		return calanderListEndDate;
	}

	public void setCalanderListEndDate(Date calanderListEndDate) {
		this.calanderListEndDate = calanderListEndDate;
	}
    
    
}

