package com.sist.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sist.common.model.FileData;
import com.sist.common.util.StringUtil;
import com.sist.web.model.Response;
import com.sist.web.model.User;
import com.sist.web.service.EditorService;
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
	private UserService userService;
	@Autowired
	private EditorService editorService;
	
	@Value("#{env['auth.user.name']}")
	private String AUTH_USER_NAME;
	
	
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
						CookieUtil.addCookie(response, "/", -1, AUTH_USER_NAME, 
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
	    
		if(CookieUtil.getCookie(request, AUTH_USER_NAME) != null)
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_USER_NAME);
		}
		
		return "redirect:/";
	}
	
	//회원가입화면
	@RequestMapping(value="/user/userRegForm", method=RequestMethod.GET)
	public String userRegForm(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_USER_NAME);
		logger.debug("cookieUserId : " + cookieUserId);
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_USER_NAME);
			
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

		String cookieUserId = CookieUtil.getHexValue(request, AUTH_USER_NAME);

		
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
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_USER_NAME);
		
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
					CookieUtil.deleteCookie(request, response, "/", AUTH_USER_NAME);
					ajaxResponse.setResponse(404, "not found");
				}
				
			}
			else
			{
				//쿠키정보와 넘어온 userId가 다른 경우
				CookieUtil.deleteCookie(request, response, "/", AUTH_USER_NAME);
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
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_USER_NAME);
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
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_USER_NAME);
		
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
	
	
	
	//카카오로그인
	//로그인 페이지
	@RequestMapping(value = "/user/kakaoLogin", method=RequestMethod.GET)
	public String kakaoLogin(@RequestParam("code") String code, HttpSession session)
	{
        
		String clientId = "80e4419557c7b5feaa6bcbaa1cae6ae8";
	    //String redirectUri = "http://finalproject.sist.co.kr:8088/user/kakaoLogin";
		String redirectUri = "http://finalproject.sist.co.kr:8088/user/kakaoLogin";
	    String tokenUrl = "https://kauth.kakao.com/oauth/token";

	    RestTemplate restTemplate = new RestTemplate();
	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

	    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
	    params.add("grant_type", "authorization_code");
	    params.add("client_id", clientId);
	    params.add("redirect_uri", redirectUri);
	    params.add("code", code);

	    HttpEntity<MultiValueMap<String, String>> tokenRequest = new HttpEntity<>(params, headers);

	    ResponseEntity<Map> response = restTemplate.postForEntity(tokenUrl, tokenRequest, Map.class);
	    Map<String, Object> body = response.getBody();

	    if (body == null || body.get("access_token") == null) {
	        throw new RuntimeException("Access Token 요청 실패 (응답 없음 또는 access_token 누락)");
	    }

	    String accessToken = (String) body.get("access_token");

	    // 세션에 저장 (추후 사용자 정보 조회에도 사용)
	    session.setAttribute("kakao_access_token", accessToken);

		//다음 단계로 리디렉션 (예: 사용자 정보 조회)
	   return "redirect:/user/kakaoUserInfo";  // 또는 메인페이지
	}

	
	@RequestMapping(value="/user/kakaoUserInfo", method=RequestMethod.GET)
	public String kakaoUserInfo(HttpSession session, Model model)
	{
		String accessToken = (String)session.getAttribute("kakao_access_token");
		
		if(accessToken == null)
		{
			throw new RuntimeException("accessToken이 세션에 없습니다.로그인부터 다시 진행하세요.");
		}
		
		//1.요청준비
		String userInfoUrl = "https://kapi.kakao.com/v2/user/me";
		RestTemplate restTemplate = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "Bearer " + accessToken);
		
		HttpEntity<String> entity = new HttpEntity<>(headers);
		
		//2.요청전송
		ResponseEntity<Map> response = restTemplate.exchange(userInfoUrl, HttpMethod.GET, entity, Map.class);
		
		Map<String, Object> body = response.getBody();
		
		//3.사용자 정보 파싱
		if(body != null)
		{
			Map<String, Object> kakaoAccount = (Map<String, Object>) body.get("kakao_account");
			Map<String, Object> properties = (Map<String, Object>) body.get("properties");
			
			String userName = (String)properties.get("nickname");

			
			Map<String, String> user = new HashMap<>();
	        user.put("userName", userName);
	        
			session.setAttribute("user", user);
			
			model.addAttribute("userName", userName);
		}
		
		return "/user/kakaoUserInfo";
	}
	
	@RequestMapping(value = "/user/kakaoLogout", method = RequestMethod.GET)
	public String kakaoLogout(HttpSession session) 
	{
	    // 세션에 저장된 로그인 정보 삭제
	    session.invalidate(); 
	    //session.removeAttribute("kakao_access_token");

	    // 로그아웃 후 이동할 페이지로 리디렉트 (예: 로그인 페이지 또는 메인페이지)
	    return "redirect:/user/login";
	}
	
	//회원탈퇴
	@PostMapping("/user/userWithdrawal")
	@ResponseBody
	public Map<String, Object> userWithdrawal(@RequestParam String userId) {
	    Map<String, Object> result = new HashMap<>();

	    try {
	        if (userId == null || userId.trim().isEmpty()) {
	            result.put("code", 400);
	            result.put("message", "userId 누락");
	            return result;
	        }

	        int success = userService.userWithdrawal(userId);  // 실제 서비스 로직

	        if (success > 0) {
	        	int count = editorService.editorStatus(userId);
	            result.put("code", 0);
	            result.put("message", "회원 탈퇴 완료 & 게시글 비공개 처리 수: "+count);
	            
	        } else {
	            result.put("code", 500);
	            result.put("message", "회원 탈퇴 실패");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("code", 500);
	        result.put("message", "서버 에러: " + e.getMessage());
	    }

	    return result;
	}

	
	//구글로그인
	//로그인 페이지
	@RequestMapping(value = "/user/googleLogin", method=RequestMethod.GET)
	public String googleLogin(@RequestParam("code") String code, HttpSession session)
	{
		// 이 부분 두줄 비밀키 문제로 지웠음.
         String redirectUri = "http://finalproject.sist.co.kr:8088/user/googleLogin";
		 String tokenUrl = "https://oauth2.googleapis.com/token";
		 
		 
		 RestTemplate restTemplate = new RestTemplate();
		 HttpHeaders headers = new HttpHeaders();
		 headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		 
		 MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
	     params.add("grant_type", "authorization_code");
//	     params.add("client_id", clientId);
//	     params.add("client_secret", clientSecret);
	     params.add("redirect_uri", redirectUri);
	     params.add("code", code);
	     
	     HttpEntity<MultiValueMap<String, String>> tokenRequest = new HttpEntity<>(params, headers);
	     
	     ResponseEntity<Map> response = restTemplate.postForEntity(tokenUrl, tokenRequest, Map.class);
	     Map<String, Object> body = response.getBody();

	     if (body == null || body.get("access_token") == null) {
	         throw new RuntimeException("구글 Access Token 요청 실패");
	     }

	     String accessToken = (String) body.get("access_token");

	     // 세션에 저장
	     session.setAttribute("google_access_token", accessToken);
		 
		 return "redirect:/user/googleUserInfo";
	}
	
	@RequestMapping(value = "/user/googleUserInfo", method = RequestMethod.GET)
	public String googleUserInfo(HttpSession session, Model model)
	{
		String accessToken = (String) session.getAttribute("google_access_token");

	    if (accessToken == null) {
	        throw new RuntimeException("accessToken이 세션에 없습니다. 로그인부터 다시 진행하세요.");
	    }
	    
	    // 1. 요청 준비
	    String userInfoUrl = "https://www.googleapis.com/oauth2/v3/userinfo";
	    RestTemplate restTemplate = new RestTemplate();
	    
	    HttpHeaders headers = new HttpHeaders();
	    headers.set("Authorization", "Bearer " + accessToken);

	    HttpEntity<String> entity = new HttpEntity<>(headers);
	    
	    // 2. 요청 전송
	    ResponseEntity<Map> response = restTemplate.exchange(userInfoUrl, HttpMethod.GET, entity, Map.class);

	    Map<String, Object> body = response.getBody();
	    
	    
	    // 3. 사용자 정보 파싱
	    if (body != null) {
	        String userName = (String) body.get("name");
	        String email = (String) body.get("email");

	        Map<String, String> user = new HashMap<>();
	        user.put("userName", userName);
	        user.put("email", email);

	        // 세션에 저장
	        session.setAttribute("user", user);

	        // 모델에 전달
	        model.addAttribute("userName", userName);
	        model.addAttribute("email", email);
	        
	    }
	    
		return "/user/googleUserInfo"; // JSP 경로
	}
	
	 
	@RequestMapping(value = "/user/googleLogout", method = RequestMethod.GET)
	public String googleLogout(HttpSession session) 
	{
	    // 세션에 저장된 로그인 정보 삭제
	    session.invalidate(); 

	    // 로그아웃 후 이동할 페이지로 리디렉트 (예: 로그인 페이지 또는 메인페이지)
	    return "redirect:/user/login";
	}
}
