package com.sist.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.web.model.Response;
import com.sist.web.model.Review;
import com.sist.web.service.ReviewService;
import com.sist.web.util.HttpUtil;

@Controller("reviewController")
public class ReviewController {

	private static Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	@Autowired
	private ReviewService reviewService;
	
	@RequestMapping(value = "/mypage/reviewPopup", method=RequestMethod.GET)
	public String reportPopup(HttpServletRequest request, HttpServletResponse response, ModelMap model)
	{
		String accommId = request.getParameter("accommId");
	    model.addAttribute("accommId", accommId);
		
	    return "/mypage/reviewPopup";
	}
	
	//리뷰 등록 ajax
	@RequestMapping(value="/mypage/review", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> review(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String accommId = HttpUtil.get(request, "accommId", "");
		String userId = HttpUtil.get(request, "userId", "");
		
		int rating = HttpUtil.get(request, "rating", 0);
		
		String content = HttpUtil.get(request, "content", "");
		
		try
		{
			Review review = new Review();
			
			review.setAccommId(accommId);
			review.setUserId(userId);
			review.setAccommReviewRating(rating);
			review.setAccommReviewContent(content);
			
			if(reviewService.reviewInsert(review)>0)
			{
				ajaxResponse.setResponse(0, "review insert success");
			}
			else
			{
				ajaxResponse.setResponse(-1, "review insert fail");
			}
		}
		catch(Exception e)
		{
			ajaxResponse.setResponse(500, "internal server error");
		}
		
		return ajaxResponse;
	}
}
