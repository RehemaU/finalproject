package com.sist.web.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sist.web.model.Accommodation;
import com.sist.web.model.Region;
import com.sist.web.model.Response;
import com.sist.web.model.Sigungu;
import com.sist.web.service.AccommodationService;
import com.sist.web.service.RegionService;
import com.sist.web.service.SigunguService;
import com.sist.web.util.HttpUtil;

@Controller("accommController")
public class AccommController 
{
	private static Logger logger = LoggerFactory.getLogger(AccommController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Value("#{env['upload.save.dir.accomm']}")
	private String UPLOAD_SAVE_DIR_ACCOMM;
	
	@Autowired
	private SigunguService sigunguService;
	
	@Autowired
	private RegionService regionService;
	
	@Autowired
	private AccommodationService accommodationService;
	
	
	@GetMapping("/accomm/accommRegForm")
	public String accommRegForm(Model model) {
		// ① 지역·시군구 데이터 조회
		List<Region>  regionList  = regionService.getAllRegions();
		List<Sigungu> sigunguList = sigunguService.getAllSigungus();

		// ② JSP에서 <c:forEach> 로 그려줄 수 있도록 모델에 담기
		model.addAttribute("regionList",  regionList);
		model.addAttribute("sigunguList", sigunguList);

		// ③ 그대로 뷰 반환
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
			if (parts.length >= 1) {
				regionName = parts[0];  // 첫 번째 부분이 지역명 (예: "서울특별시")
				logger.debug("지역명 추출: " + regionName);
			}
		}
		logger.debug("최종 지역명: " + regionName);
		
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
				sigunguName = parts[1];  // 두 번째 부분이 시군구명 (예: "강서구")
			}
		}
		logger.debug("[시군구 검색] sigunguName: " + sigunguName + ", regionId: " + regionId);

		Sigungu sigungu = sigunguService.sigunguSelect(regionId, sigunguName);

		if (sigungu != null) {
			ajaxResponse.setCode(0);
			ajaxResponse.setData(sigungu);
		} else {
			ajaxResponse.setCode(1);
		}
			
		return ajaxResponse;	
	}

	// 숙소 등록 처리 - URL 매핑 수정
	@RequestMapping(value = "/accomm/insert", method = RequestMethod.POST)
	public String insertAccommodation(@ModelAttribute Accommodation accom,
	                                  @RequestParam("firstImageFile") MultipartFile firstImageFile,
	                                  HttpServletRequest request,
	                                  HttpSession session,
	                                  Model model) {


	    try {
	        session.setAttribute("SELLER_ID", "test3");  // 🔥 테스트용: 등록되는지 확인

	        // 1. 로그인한 사용자 ID 세팅 (판매자 ID)
	        String sellerId = (String) session.getAttribute("SELLER_ID");
	        if (sellerId == null) {
	            model.addAttribute("msg", "로그인이 필요합니다.");
	            return "/user/login"; // 로그인 페이지로
	        }
	        accom.setSellerId(sellerId);

	        // 2. 상태 기본값
	        accom.setAccomStatus("Y");

	        // 3. 이미지 저장 처리
	        if (firstImageFile != null && !firstImageFile.isEmpty()) {

	            /* (2-1) 저장할 파일명 만들기 ─ 중복 방지를 위해 시간값 + 확장자 */
	            String origin   = firstImageFile.getOriginalFilename();         
	            String ext      = origin.substring(origin.lastIndexOf("."));     
	            String saveName = "accomm_" + System.currentTimeMillis() + ext;  

	            /* (2-2) 디스크(물리) 경로에 저장 */
	            File dir = new File(UPLOAD_SAVE_DIR_ACCOMM);
	            if (!dir.exists()) dir.mkdirs();

	            File dest = new File(dir, saveName);       
	            firstImageFile.transferTo(dest);

	            /* (2-3) DB에는 ‘웹 경로’만 남기기 */
	            accom.setFirstImage("/upload/accomm/" + saveName);

	            logger.debug("대표 이미지 저장 완료 : {}", dest.getAbsolutePath());
	        }
	        //-------------------------------------------------------------

	        accommodationService.insertAccommodationForm(accom);
	        return "redirect:/accomm/list";

	    } catch (Exception e) {
	        logger.error("숙소 등록 오류", e);
	        model.addAttribute("msg", "숙소 등록 중 오류: " + e.getMessage());
	        return "/error";
	    }
	}
}