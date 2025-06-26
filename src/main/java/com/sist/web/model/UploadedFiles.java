package com.sist.web.model;

import java.io.Serializable;

public class UploadedFiles implements Serializable {

	private static final long serialVersionUID = -1113873931545289267L;
	
	private String imageFileId;
    private String boardId;
    private String imageFilePath;
    private String imageOrgName;
    private String imageFileExt;
    private int imageFileSize;
    private String imageFileRegdate;
    
    public UploadedFiles()
    {
    	imageFileId = "";
        boardId = "";
        imageFilePath = "";
        imageOrgName = "";
        imageFileExt = "";
        imageFileSize = 0;
        imageFileRegdate = "";
    }

    //getter-setter
	public String getImageFileId() {
		return imageFileId;
	}

	public void setImageFileId(String imageFileId) {
		this.imageFileId = imageFileId;
	}

	public String getBoardId() {
		return boardId;
	}

	public void setBoardId(String boardId) {
		this.boardId = boardId;
	}

	public String getImageFilePath() {
		return imageFilePath;
	}

	public void setImageFilePath(String imageFilePath) {
		this.imageFilePath = imageFilePath;
	}

	public String getImageOrgName() {
		return imageOrgName;
	}

	public void setImageOrgName(String imageOrgName) {
		this.imageOrgName = imageOrgName;
	}

	public String getImageFileExt() {
		return imageFileExt;
	}

	public void setImageFileExt(String imageFileExt) {
		this.imageFileExt = imageFileExt;
	}

	public int getImageFileSize() {
		return imageFileSize;
	}

	public void setImageFileSize(int imageFileSize) {
		this.imageFileSize = imageFileSize;
	}

	public String getImageFileRegdate() {
		return imageFileRegdate;
	}

	public void setImageFileRegdate(String imageFileRegdate) {
		this.imageFileRegdate = imageFileRegdate;
	}
    
}
