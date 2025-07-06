package com.sist.web.model;

import java.io.Serializable;

public class Notice implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1337486807037624215L;

	private String noticeId;       // 공지사항 ID
    private String adminId;        // 작성한 관리자 ID
    private String noticeTitle;    // 제목
    private String noticeContent;  // 내용
    private String noticeRegdate;  // 등록일 (String으로 처리)
    private int noticeCount;       // 조회수
	
    public Notice() 
    {
        this.noticeId = "";
        this.adminId = "";
        this.noticeTitle = "";
        this.noticeContent = "";
        this.noticeRegdate = "";
        this.noticeCount = 0;
    }

	public String getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(String noticeId) {
		this.noticeId = noticeId;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	public String getNoticeRegdate() {
		return noticeRegdate;
	}

	public void setNoticeRegdate(String noticeRegdate) {
		this.noticeRegdate = noticeRegdate;
	}

	public int getNoticeCount() {
		return noticeCount;
	}

	public void setNoticeCount(int noticeCount) {
		this.noticeCount = noticeCount;
	}
    
    
    
}
