package com.sist.web.model;

import java.io.Serializable;

public class Editor implements Serializable {

	private static final long serialVersionUID = 39097446595075942L;

    private String planId;
    private String userId;
    private String planTitle;
    private String planContent;
    private String planRegdate;
    private int planCount;
    private int planReport;
    private int planRecommend;
    private String tCalanderListId;

    private String listType;
    private String searchType;
    private String searchValue;
    
	private long startRow;			//시작페이지 rownum
	private long endRow;			//끝페이지 rownum
	
	public Editor()
	{
	    planId = "";
	    userId = "";
	    planTitle = "";
	    planContent = "";
	    planRegdate = "";
	    planCount = 0;
	    planReport = 0;
	    planRecommend = 0;
	    tCalanderListId  = "";
	    
	    listType = "";
	    searchType = "";
	    searchValue = "";
	    
	    startRow = 0;
	    endRow = 0;
	}

	//getter-setter
	public String getPlanId() {
		return planId;
	}

	public void setPlanId(String planId) {
		this.planId = planId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPlanTitle() {
		return planTitle;
	}

	public void setPlanTitle(String planTitle) {
		this.planTitle = planTitle;
	}

	public String getPlanContent() {
		return planContent;
	}

	public void setPlanContent(String planContent) {
		this.planContent = planContent;
	}

	public String getPlanRegdate() {
		return planRegdate;
	}

	public void setPlanRegdate(String planRegdate) {
		this.planRegdate = planRegdate;
	}

	public int getPlanCount() {
		return planCount;
	}

	public void setPlanCount(int planCount) {
		this.planCount = planCount;
	}

	public int getPlanReport() {
		return planReport;
	}

	public void setPlanReport(int planReport) {
		this.planReport = planReport;
	}

	public int getPlanRecommend() {
		return planRecommend;
	}

	public void setPlanRecommend(int planRecommend) {
		this.planRecommend = planRecommend;
	}

	public String getTCalanderListId() {
		return tCalanderListId;
	}

	public void setTCalanderListId(String tCalanderListId) {
		this.tCalanderListId = tCalanderListId;
	}
	
	public String getListType() {
		return listType;
	}
	
	public void setListType(String listType) {
		this.listType = listType;
	}
	
	public String getSearchType() {
		return searchType;
	}
	
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	
	public String getSearchValue() {
		return searchValue;
	}
	
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	
	public long getStartRow() {
		return startRow;
	}
	
	public void setStartRow(long startRow) {
		this.startRow = startRow;
	}
	
	public long getEndRow() {
		return endRow;
	}
	
	public void setEndRow(long endRow) {
		this.endRow = endRow;
	}
	
}
