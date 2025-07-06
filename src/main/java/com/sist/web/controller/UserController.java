package com.sist.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sist.common.model.FileData;
import com.sist.common.util.StringUtil;
import com.sist.web.model.Response;
import com.sist.web.model.User;
import com.sist.web.service.UserService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;
import com.sist.web.util.JsonUtil;
import com.sist.web.util.SessionUtil;

@Controller("userController")
public class UserController 
{
	private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Autowired
	private	 UserService userService;
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	
	//로그인 페이지
	@RequestMapping(value = "/user/login", method=RequestMethod.GET)
	public String login(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/login";
	}	
	
	//로그인
	@RequestMapping(value="/user/loginProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> loginProc(HttpServletRequest request, 
											HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userId = HttpUtil.get(request, "userId");
		String userPassword = HttpUtil.get(request, "userPassword");
		
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPassword))
		{
			User user = userService.userSelect(userId);
			
			if(user != null)
			{
				if(StringUtil.equals(userPassword, user.getUserPassword()))
				{
					
					if(StringUtil.equals(user.getUserOut(), "N"))
					{
						CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME, 
                                CookieUtil.stringToHex(userId));
						
				        // 로그인 성공 → 세션 저장
				        HttpSession session = request.getSession(true); // 세션이 없으면 생성
				        session.setAttribute("userId", user.getUserId());
				        logger.debug("SessionUserId 111: " + user.getUserId());
				        logger.debug("SessionUserId 222: " + userId);
				        
						logger.debug("userId : " + userId);
						logger.debug("userPassword hex : " + CookieUtil.stringToHex(userId));
						ajaxResponse.setResponse(0, "success");
					}
					else
					{
						ajaxResponse.setResponse(-99, "status error");
					}
				}
				else
				{
					//비밀번호 불일치
					ajaxResponse.setResponse(-1, "password mismatch");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "not found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController]/user/login response \n" +
										JsonUtil.toJsonPretty(ajaxResponse));
		}

		return ajaxResponse;	
	}
	
	//로그아웃
	@RequestMapping(value="/user/loginOut", method=RequestMethod.GET)
	public String loginOut(HttpServletRequest request, HttpServletResponse response)
	{
		
		// 세션 종료
	    request.getSession().invalidate();
	    
		if(CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null)
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
		}
		
		return "redirect:/user/login";
	}
	
	//회원가입화면
	@RequestMapping(value="/user/userRegForm", method=RequestMethod.GET)
	public String userRegForm(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		logger.debug("cookieUserId : " + cookieUserId);
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
			
			return "redirect:/user/login";
			
		}
		else
		{
			return "/user/userRegForm";
		}
	}
	
	//아이디 중복체크
	@RequestMapping(value="/user/idCheck", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> idCheck(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userId = HttpUtil.get(request, "userId");
		
		if(!StringUtil.isEmpty(userId))
		{
			if(userService.userSelect(userId) == null)
			{
				//사용가능한 아이디
				ajaxResponse.setResponse(0, "success");
			}
			else
			{
				//중복아이디 발생
				ajaxResponse.setResponse(100, "deplicate id");		
			}	
		}
		else
		{
			ajaxResponse.setResponse(400, "bad request");
		}
		
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController]/user/idCheck response \n" + 
									JsonUtil.toJsonPretty(ajaxResponse));
		}

		return ajaxResponse;
	}
	
	//회원등록
	@RequestMapping(value="/user/userRegProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> userRegProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String userId = HttpUtil.get(request, "userId", "");
		String userPassword = HttpUtil.get(request, "userPassword2");
		String userName = HttpUtil.get(request, "userName", "");
		String userGender = HttpUtil.get(request, "userGender", "");
		String userNumber = HttpUtil.get(request, "userNumber", "");
		String zipCode = HttpUtil.get(request, "zipCode","");
		String streetAdr = HttpUtil.get(request, "streetAdr","");
		String detailAdr = HttpUtil.get(request, "detailAdr","");
		String userAdd = zipCode + "|" + streetAdr + "|" +detailAdr;
		String userBirth = HttpUtil.get(request, "userBirth","");
		String userEmail = HttpUtil.get(request, "userEmail","");
		FileData fileData = HttpUtil.getFile(request, "userProfile", UPLOAD_SAVE_DIR, userId);
		
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPassword) && !StringUtil.isEmpty(userName) &&
				!StringUtil.isEmpty(userGender) && !StringUtil.isEmpty(userNumber) && !StringUtil.isEmpty(userAdd) &&
					!StringUtil.isEmpty(userBirth)&& !StringUtil.isEmpty(userEmail))
		{
			//아이디 중복 체크
			if(userService.userSelect(userId) == null)
			{
				User user = new User();
				user.setUserId(userId);
				user.setUserPassword(userPassword);
				user.setUserName(userName);
				user.setUserGender(userGender);
				user.setUserNumber(userNumber);
				user.setUserAdd(userAdd);
				user.setUserBirth(userBirth);
				user.setUserEmail(userEmail);
//				user.setUserProfile(fileData.getFileExt()); // 혹은 저장 후 파일명
	            if (fileData != null && fileData.getFileName() != null) {
	                user.setUserProfile(fileData.getFileExt()); // 혹은 저장 후 파일명
	            }
				
				if(userService.userInsert(user) > 0)
				{
					ajaxResponse.setResponse(0, "success");
				}
				else
				{
					ajaxResponse.setResponse(500, "internal server error");
				}

			}
			else
			{
				//중복 아이디 존재시
				ajaxResponse.setResponse(100, "duplicate id");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "bad request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController]/user/regProc response \n" +
										JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
		
	}
	
	//회원정보 수정화면           
	//디스패쳐 서블릿에서 호출
	@RequestMapping(value="/user/userUpdateForm", method=RequestMethod.GET)
	public String userUpdateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키를 가져옴
		//String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String userId = (String) request.getSession().getAttribute("userId");
		
		if(userId == null || userId == "")
		{
			return "/user/login";
		}
		
		User user = userService.userSelect(userId);
		
		String userAdd = user.getUserAdd(); // 예: "12345 서울시 강남구 테헤란로 1길 5"
		String zipCode = "";
		String streetAdr = "";
		String detailAdr = "";
		
		if (userAdd != null) {
		    String[] parts = userAdd.split("\\|");

		    zipCode = (parts.length > 0) ? parts[0] : "";
		    streetAdr = (parts.length > 1) ? parts[1] : "";
		    detailAdr = (parts.length > 2) ? parts[2] : "";
		}
		
		String userProfile = user.getUserProfile();
		model.addAttribute("zipCode", zipCode);
		model.addAttribute("streetAdr", streetAdr);
		model.addAttribute("detailAdr", detailAdr);
		
		model.addAttribute("userProfile", userProfile);
		
		model.addAttribute("user", user);

		return "/user/userUpdateForm";
	}
	
	//회원정보 수정(ajax 통신용)
	@RequestMapping(value="/user/userUpdateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> userUpdateProc(MultipartHttpServletRequest request, 
			HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userId = HttpUtil.get(request, "userId", "");
		String userName = HttpUtil.get(request, "userName", "");
		String userGender = HttpUtil.get(request, "userGender", "");
		String userNumber = HttpUtil.get(request, "userNumber", "");
		String zipCode = HttpUtil.get(request, "zipCode","");
		String streetAdr = HttpUtil.get(request, "streetAdr","");
		String detailAdr = HttpUtil.get(request, "detailAdr","");
		String userAdd = zipCode + "|" + streetAdr + "|" +detailAdr;
		String userBirth = HttpUtil.get(request, "userBirth","");
		String userEmail = HttpUtil.get(request, "userEmail","");
		FileData fileData = HttpUtil.getFile(request, "userProfile", UPLOAD_SAVE_DIR, userId);
		
	
		if (userBirth != null) 
		{
			userBirth = userBirth.replaceAll("-", "");
		}
		//cookieUserId 와 userid는 같아야 수정가능
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			if(StringUtil.equals(userId, cookieUserId))
			{
				User user = userService.userSelect(cookieUserId);
				
				if(user != null)
				{
					if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userName) &&
							!StringUtil.isEmpty(userGender) && !StringUtil.isEmpty(userNumber) && 
								!StringUtil.isEmpty(userAdd) && !StringUtil.isEmpty(userBirth) && 
									!StringUtil.isEmpty(userEmail))
					{
						user.setUserId(userId);
						user.setUserName(userName);
						user.setUserGender(userGender);
						user.setUserNumber(userNumber);
						user.setUserAdd(userAdd);
						user.setUserBirth(userBirth);
						user.setUserEmail(userEmail);
						
						
						if (fileData != null && fileData.getFileName() != null) {
			                user.setUserProfile(fileData.getFileExt()); // 혹은 저장 후 파일명
			            }
						
						if(userService.userUpdate(user) > 0)
						{
							ajaxResponse.setResponse(0, "success");
						}
						else
						{
							ajaxResponse.setResponse(500, "internal server error");
						}
						
					}
					else
					{
						//파라미터 값이 올바르지 않을 경우
						ajaxResponse.setResponse(400, "bad request");
					}
					
				}
				else
				{
					//사용자 정보가 없는경우
					CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
					ajaxResponse.setResponse(404, "not found");
				}
				
			}
			else
			{
				//쿠키정보와 넘어온 userId가 다른 경우
				CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
				ajaxResponse.setResponse(430, "id infomation is different");	
			}
		}
		else
		{
			ajaxResponse.setResponse(410, "loging failed");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController]/user/userUpdateProc response \n" +
					JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	
	//회원가입화면
	@RequestMapping(value="/user/userPasswordForm", method=RequestMethod.GET)
	public String userPasswordForm(HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키값
		//String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		return "/user/userPasswordForm";
	}
	
	//회원 패스워드 변경
	@RequestMapping(value="/user/userPasswordChange", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> userPasswordChange(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		{
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			String newPassword = HttpUtil.get(request, "userPassword");
			
			logger.debug("입력한 비밀번호3333333:>>>>>>>>>>><<<<<<<<<<<<<<<<"+newPassword);
			
			User user = userService.userSelect(cookieUserId);
			
			user.setUserPassword(newPassword);
			
			if(userService.userPasswordChange(user) > 0)
			{
				ajaxResponse.setResponse(0, "success");
			}
			else 
			{
				ajaxResponse.setResponse(500, "internal server error");
			}	
		}
			
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController]/user/userPasswordChange response \n" +
					JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	//현재비밀번호 체크
	@RequestMapping(value="/user/checkCurrentPassword")
	@ResponseBody
	public boolean checkCurrentPassword(HttpServletRequest request)
	{
		String currentPassword = HttpUtil.get(request, "currentPassword");
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		logger.debug("입력한 비밀번호:>>>>>>>>>>><<<<<<<<<<<<<<<<"+currentPassword);
		
		User user = userService.userSelect(cookieUserId);
		
		logger.debug("DB 비밀번호: >>>>>>>>>>><<<<<<<<<<<<<<<<" + user.getUserPassword());
		return user.getUserPassword().equals(currentPassword);

	}
	
	//회원댓글관리
	@RequestMapping(value="/user/userCommentForm", method=RequestMethod.GET)
	public String userCommentForm(HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키값
		//String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		return "/user/userCommentForm";
	}
}
