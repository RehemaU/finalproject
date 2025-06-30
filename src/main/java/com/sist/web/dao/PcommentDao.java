package com.sist.web.dao;

import java.util.List;

import com.sist.web.model.Pcomment;

public interface PcommentDao {

	//댓글등록
	public int pcommentInsert(Pcomment pcomment);
	//댓글목록
	public List<Pcomment> pcommentList(int planId);
}
