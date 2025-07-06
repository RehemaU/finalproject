package com.sist.web.controller;

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
import com.sist.web.service.EditorService;
import com.sist.web.service.PcommentService;
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
	
	//------------------------------------------------------------------------------
	@RequestMapping(value = "/mypage/main", method=RequestMethod.GET)
	public String Main(HttpServletRequest request, HttpServletResponse response)
	{
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
			if(userId != null)
			{
				list = editorService.editorMyplan(userId);
			}
			else
			{
				System.out.println("로그인 필요");
			}
		}
		catch(Exception e)
		{
			logger.error("[EditorController]myPlanlist Exception", e);
		}
		
		model.addAttribute("list", list);
		
		return "/mypage/planlist";
	}
	
}
