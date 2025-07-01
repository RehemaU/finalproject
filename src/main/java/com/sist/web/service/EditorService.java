package com.sist.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sist.web.dao.EditorDao;
import com.sist.web.model.Editor;

@Service("editorService")
public class EditorService {
	private static Logger logger = LoggerFactory.getLogger(EditorService.class);
	
	@Autowired
	private EditorDao editorDao;
	
	//게시물등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int editorInsert(Editor editor) throws Exception
	{
		int count = 0;
		
		try
		{
			count = editorDao.editorInsert(editor);
		}
		catch(Exception e)
		{
			logger.error("[EditorService] editorInsert : ", e);
		}
		
		return count;
	}
	
	//게시물갯수
	public int editorListCount(Editor editor)
	{
		int count = 0;
		
		try
		{
			count = editorDao.editorListCount(editor);
		}
		catch(Exception e)
		{
			logger.error("[EditorService] editorListCount : ", e);
		}
		
		return count;
	}
	
	//게시물리스트
	public List<Editor> editorList(Editor editor)
	{
		List<Editor> list = null;
		
		try
		{
			list = editorDao.editorList(editor);
		}
		catch(Exception e)
		{
			logger.error("[EditorService] editorList Exception : ", e);
		}
		
		return list;
	}
	
	//게시물 조회
	public Editor editorSelect(int planId)
	{
		Editor editor = null;
		
		try
		{
			editor = editorDao.editorSelect(planId);
		}
		catch(Exception e)
		{
			logger.error("[EditorService]editorSelect Exception", e);
		}
		
		return editor;
	}
	
	//게시물 수정
	public int editorUpdate(Editor editor)
	{
		int count = 0;
		
		try
		{
			count = editorDao.editorUpdate(editor);
		}
		catch(Exception e)
		{
			logger.error("[EditorService]editorUpdate Exception", e);
		}
		
		return count;
	}
	
	public int editorDelete(int planId)
	{
		int count = 0;
		
		try
		{
			count = editorDao.editorDelete(planId);
		}
		catch(Exception e)
		{
			logger.error("[EditorService]editorDelete Exception", e);
		}
		
		return count;
	}
	
}
