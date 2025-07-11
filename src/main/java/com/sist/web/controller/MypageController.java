package com.sist.web.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sist.web.model.Editor;
import com.sist.web.model.Order;
import com.sist.web.model.OrderDetail;
import com.sist.web.model.Pcomment;
import com.sist.web.model.User;
import com.sist.web.service.EditorService;
import com.sist.web.service.OrderService;
import com.sist.web.service.PcommentService;
import com.sist.web.service.RecommendService;
import com.sist.web.service.UserService;

@Controller("mypageController")
public class MypageController {

	private static Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	@Autowired
	private EditorService editorService;
	@Autowired
	private PcommentService pcommentService;
	@Autowired
	private UserService userService;
	@Autowired
	private RecommendService recommendService;
	@Autowired
	private OrderService orderService;
	
	//------------------------------------------------------------------------------
	@RequestMapping(value = "/mypage/main", method=RequestMethod.GET)
	public String Main(HttpServletRequest request, HttpServletResponse response)
	{
		String userId = (String) request.getSession().getAttribute("userId");
		if(userId == null || userId =="")
		{
			return "/user/login";
		}
		return "/mypage/main";
	}
	//------------------------------------------------------------------------------
	
	//내후기조회
	@RequestMapping(value="/mypage/planlist")
	public String myPlanlist(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String userId = (String) request.getSession().getAttribute("userId");
		
		List<Editor> list = null;
		
		try
		{
			list = editorService.editorMyplan(userId);
		}
		catch(Exception e)
		{
			logger.error("[MypageController]myPlanlist Exception", e);
		}
		
		model.addAttribute("list", list);
		
		return "/mypage/planlist";
	}
	
	//내댓글조회
	@RequestMapping(value="/mypage/commentlist")
	public String myCommentlist(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String userId = (String) request.getSession().getAttribute("userId");
		
		List<Pcomment> list = null;
		Editor editor = null;
		
		String planTitle = "";
		
		try
		{
			list = pcommentService.pcommentMycomment(userId);
			for(Pcomment pcomment : list)
			{
				editor = editorService.editorSelect(Integer.parseInt(pcomment.getPlanId()));
				planTitle = editor.getPlanTitle();
				pcomment.setPlanTitle(planTitle);
			}
		}
		catch(Exception e)
		{
			logger.error("[MypageController]pcommentMycomment Exception", e);
		}
		
		model.addAttribute("list", list);
		
		return "/mypage/commentlist";
	}
	
	//좋아요 누른 게시글 조회
	@RequestMapping(value="/mypage/recommendlist")
	public String myRecommendlist(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String userId = (String) request.getSession().getAttribute("userId");
		
		List<Integer> list = null;
		Editor editor = null;
		List<Editor> editorlist = new ArrayList<>();
		String thumbnail = "";
		User user = null;
		String userName = "";
		String userImgEx = "";
		try
		{
			list = recommendService.recommendList(userId);
			
			for(int planId : list)
			{
				editor = editorService.editorSelect(planId);
				thumbnail = editorService.editorThumbnail(planId);
				editor.setThumbnail(thumbnail);
				user = userService.userSelect(editor.getUserId());
	            userName = user.getUserName();
	            userImgEx = user.getUserProfile();
	            editor.setUserName(userName);
	            editor.setUserImgEx(userImgEx);
	            editorlist.add(editor);
			}
		}
		catch(Exception e)
		{
			logger.error("[MypageController]myRecommendlist Exception", e);
		}
		
		model.addAttribute("list", editorlist);
		
		return "/mypage/recommendlist";
	}
	
	//내 결제 내역
	@RequestMapping(value="/mypage/orderlist")
	public String orderlist(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String userId = (String) request.getSession().getAttribute("userId");
		
		List<Order> list = null;
		
		try
		{
			list = orderService.userOrderlist(userId);
		}
		catch(Exception e)
		{
			logger.error("[MypageController]myPlanlist Exception", e);
		}
		
		model.addAttribute("list", list);
		
		return "/mypage/orderlist";
	}
	
	// 내 결제 상세
	@RequestMapping(value="/mypage/orderdetail")
	public String orderdetail(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
	    String orderId = request.getParameter("orderId");
	    
	    boolean isReview = false;
	    boolean isRefund = false;
	    
	    if(orderService.userOrderCheckin(orderId)>0)
	    {
	    	isRefund = true;
	    }
	    if(orderService.userOrderCheckout(orderId)>0)
	    {
	    	isReview = true;
	    }
	    
	    OrderDetail orderDetail = orderService.userOrderDetails(orderId);
	    model.addAttribute("orderDetail", orderDetail);
		
	    Date cidate = orderDetail.getOrderDetailsCheckinDate();
	    Date codate = orderDetail.getOrderDetailsCheckoutDate();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    String checkinDate = sdf.format(cidate);
	    String checkoutDate = sdf.format(codate);
	    model.addAttribute("checkinDate", checkinDate);
	    model.addAttribute("checkoutDate", checkoutDate);
	    
	    model.addAttribute("isRefund", isRefund);
	    model.addAttribute("isReview", isReview);
	    
		return "/mypage/orderdetail";
	}
}
