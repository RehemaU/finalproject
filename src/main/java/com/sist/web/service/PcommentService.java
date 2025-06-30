package com.sist.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sist.web.dao.PcommentDao;
import com.sist.web.model.Pcomment;

@Service("pcommentService")
public class PcommentService {

	private static Logger logger = LoggerFactory.getLogger(PcommentService.class);
	
	@Autowired
	private PcommentDao pcommentDao;
	
	//댓글등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int pcommentInsert(Pcomment pcomment) throws Exception
	{
		int count = 0;
		
		try
		{
			count = pcommentDao.pcommentInsert(pcomment);
		}
		catch(Exception e)
		{
			logger.error("[PcommentService] pcommentInsert : ", e);
		}
		
		return count;
	}
	
	//댓글목록
	public List<Pcomment> pcommentList(int PlanId)
	{
		List<Pcomment> list = null;
		
		try
		{
			list = pcommentDao.pcommentList(PlanId);
		}
		catch(Exception e)
		{
			logger.error("[PcommentService] pcommentList : ", e);
		}
		
		return list;
	}
	
	//댓글삭제
	public int pcommentDelete(int commentId)
	{
		int count = 0;
		
		try
		{
			count = pcommentDao.pcommentDelete(commentId);
		}
		catch(Exception e)
		{
			logger.error("[PcommentService] pcommentDelete : ", e);
		}
		
		return count;
	}
	

}
