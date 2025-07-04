package com.sist.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.web.model.Region;
import com.sist.web.model.Response;
import com.sist.web.model.Sigungu;
import com.sist.web.service.RegionService;
import com.sist.web.service.SigunguService;
import com.sist.web.util.HttpUtil;

@Controller("accommController")
public class AccommController 
{
	private static Logger logger = LoggerFactory.getLogger(AccommController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	
    @Autowired
    private SigunguService sigunguService;
    
    @Autowired
    private RegionService regionService;
	
	
	//숙소등록 페이지
	@RequestMapping(value = "/accomm/accommRegForm", method=RequestMethod.GET)
	public String accommRegForm(Model model, HttpServletRequest request, HttpServletResponse response)
	{
		
		return "/accomm/accommRegForm";
	}
	
	//지역코드조회 추가
	@RequestMapping(value = "/accomm/regionSelect", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> regionSelect(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String fullAddress = HttpUtil.get(request, "streetAdr", "");
		
		String regionName = "";
		if (fullAddress != null && !fullAddress.isEmpty()) {
	        String[] parts = fullAddress.split(" ");
	        if (parts.length >= 2) {
	        	regionName = parts[0];  // 예: "강서구"
	            logger.debug("1111111111111111"+regionName);
	        }
	    }
		logger.debug(">>>>>>>>>>>>>>22222<<<<<<<<<<<<"+regionName);
		
		Region region = regionService.regionSelect(regionName);
		
		if (region != null) {
	        ajaxResponse.setCode(0);
	        ajaxResponse.setData(region);
	    } else {
	        ajaxResponse.setCode(1);
	    }
			
		return ajaxResponse;	
	}
	
	
	//시군구코드조회 추가
	@RequestMapping(value = "/accomm/sigunguSelect", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> sigunguSelect(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String fullAddress = HttpUtil.get(request, "streetAdr", "");
		String regionId = HttpUtil.get(request, "regionId", "");
		String sigunguName = "";
		if (fullAddress != null && !fullAddress.isEmpty()) {
	        String[] parts = fullAddress.split(" ");
	        if (parts.length >= 2) {
	            sigunguName = parts[1];  // 예: "강서구"
	        }
	    }
	    logger.debug("[시군구 검색] sigunguName: " + sigunguName);

	    Sigungu sigungu = sigunguService.sigunguSelect(regionId, sigunguName);

	    if (sigungu != null) {
	        ajaxResponse.setCode(0);
	        ajaxResponse.setData(sigungu);
	    } else {
	        ajaxResponse.setCode(1);
	        //ajaxResponse.setMessage("시군구를 찾을 수 없습니다.");
	    }
			
		return ajaxResponse;	
	}

}
