package com.sist.web.dao;

import com.sist.web.model.Review;

public interface ReviewDao {

	//리뷰 등록
	public int reviewInsert(Review review);
	//리뷰 있나 조회
	public int reviewCount(Review review);
}
