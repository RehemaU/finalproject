package com.sist.web.dao;

import java.util.List;

import com.sist.web.model.Editor;

public interface EditorDao {
	
	//게시글등록
	public int editorInsert(Editor editor);
	//게시글수조회
	public int editorListCount(Editor editor);
	//게시글리스트
	public List<Editor> editorList(Editor editor);
	//게시글상세조회
	public Editor editorSelect(int planId);
	//게시글수정
	public int editorUpdate(Editor editor);
	//게시글삭제
	public int editorDelete(int planId);
}
