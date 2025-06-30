package com.sist.web.dao;

import java.util.List;

import com.sist.web.model.Pcomment;

public interface PcommentDao {

	//댓글등록
	public int pcommentInsert(Pcomment pcomment);
	//댓글목록
	public List<Pcomment> pcommentList(int planId);
	//댓글삭제
	public int pcommentDelete(int commentId);
	//댓글수정
	public int pcommentUpdate(Pcomment pcomment);
	//댓글선택
	public Pcomment pcommentSelect(int commentId);
}
