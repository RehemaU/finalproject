package com.sist.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.ReviewDao;
import com.sist.web.model.Review;

@Service("reviewService")
public class ReviewService {

	private static Logger logger = LoggerFactory.getLogger(ReviewService.class);
	
	@Autowired
	private ReviewDao reviewDao;
	
	//리뷰 등록
	public int reviewInsert(Review review)
	{
		int count = 0;
		
		try
		{
			count = reviewDao.reviewInsert(review);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService]reviewInsert Exception", e);
		}
		
		return count;
	}
	
	//리뷰 있나 조회
	public int reviewCount(Review review)
	{
		int count = 0;
		
		try
		{
			count = reviewDao.reviewCount(review);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService]reviewCount Exception", e);
		}
		
		return count;
	}

}
