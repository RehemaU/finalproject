
package com.sist.web.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.sist.web.service.EditorService;
import com.sist.web.util.HttpUtil;
import com.sist.common.util.StringUtil;
import com.sist.web.model.*;

import com.sist.web.util.CookieUtil;

@Controller("editorController")
public class EditorController
{
	private static Logger logger = LoggerFactory.getLogger(EditorController.class);

	@Autowired
	private EditorService editorService;
	
	private static final int LIST_COUNT = 10; 	// 한 페이지의 게시물 수
	private static final int PAGE_COUNT = 2;	// 페이징 수
	
	//--------------------------------------------------------------
	
	@RequestMapping(value = "/editor/planeditor", method=RequestMethod.GET)
	public String Editor(HttpServletRequest request, HttpServletResponse response)
	{
		return "/editor/planeditor";
	}
	

	
	//--------------------------------------------------------------
	
	//게시글작성(part-1)
	@RequestMapping(value = "/editor/fileupload", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> fileUpload(HttpServletRequest request,
	                                      @RequestParam("image") MultipartFile image) {
	    Map<String, Object> result = new HashMap<>();

	    if (image == null || image.isEmpty()) {
	        result.put("error", "No image uploaded");
	        return result;
	    }

	    try {
	        // 실제 파일 저장 경로 (절대경로로 바꿔줘야 함)
	        String uploadDir = "C:\\project\\webapps\\finalproject\\src\\main\\webapp\\WEB-INF\\views\\resources\\editorupload";
	        File dir = new File(uploadDir);
	        if (!dir.exists()) {
	            dir.mkdirs();
	        }

	        String originalName = image.getOriginalFilename();
	        String extension = org.apache.commons.io.FilenameUtils.getExtension(originalName);
	        String newFileName = UUID.randomUUID().toString() + "." + extension;

	        File uploadedFile = new File(dir, newFileName);
	        image.transferTo(uploadedFile);

	        // 클라이언트에 제공할 URL
	        String imageUrl = "/resources/editorupload/" + newFileName;
	        result.put("url", imageUrl);
	        logger.info("이미지 업로드 완료: {}", imageUrl);

	    } catch (Exception e) {
	        logger.error("이미지 업로드 실패", e);
	        result.put("error", "Upload failed: " + e.getMessage());
	    }

	    return result;
	}
	
	//게시글 작성(part-2)
	@RequestMapping(value = "/editor/submit", method = RequestMethod.POST)
	@ResponseBody
	public Response<JsonObject> readyAjax(@RequestBody Editor editor) {
	    Response<JsonObject> res = new Response<>();

	    if (editor == null) {
	        res.setResponse(400, "요청 본문이 없습니다.");
	        return res;
	    }

	    String planTitle = editor.getPlanTitle();
	    String planContent = editor.getPlanContent();


	    JsonObject data = new JsonObject();
	    data.addProperty("title", planTitle);
	    data.addProperty("content", planContent);
	    
	    editor.setPlanTitle(planTitle);
	    editor.setPlanContent(planContent);
	    editor.setTCalanderListId("e6cdfef5-0e6d-40fc-bae4-17203c893a75");

	    logger.info("제목: " + planTitle);
	    logger.info("내용: " + planContent);

	    try
	    {
	    	int num = editorService.editorInsert(editor);
	    	
	    	if(num>0)
	    	{
	    		res.setResponse(200, "success");	    		
	    	}
	    	else
	    	{
	    		res.setResponse(400, "Fail: Not inserted");
	    	}
	    }
	    catch(Exception e)
	    {
	    	logger.error("에러메시지", e);
	    	res.setResponse(400, e.getMessage());
	    }
	    
	    return res;
	}
	
	//게시글 리스트
	@RequestMapping(value="/editor/planlist")
	public String planList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		// 리스트항목
		String listType = HttpUtil.get(request, "listType", "");
		// 조회항목(1: 작성자, 2: 제목, 3: 내용)
		String searchType = HttpUtil.get(request, "searchType", "");
		// 조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		// 현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		//게시물 리스트
		List<Editor> list = null;
		// 조회 객체
		Editor search = new Editor();
		// 총 게시물 수
		long totalCount = 0;
		// 페이징 객체
		Paging paging = null;
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);
		}
		if(!StringUtil.isEmpty(listType))
		{
			search.setListType(listType);
		}
		else
		{
			listType = "";
			searchType = "";
			searchValue = "";
		}
		
		totalCount = editorService.editorListCount(search);
		
		logger.debug("&*& 현재 게시물 수 : " + totalCount + " &*&");
		
		if(totalCount > 0)
		{	
			paging = new Paging("/editor/planlist", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			
			list = editorService.editorList(search);
		}
		
		// return 값으로 전달
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("list", list);
		model.addAttribute("listType", listType);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		
		return "/editor/planlist";
	}
	
	//게시글 조회
	@RequestMapping(value="/editor/planview")
	public String planSelect(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		// 게시물 번호
		int planId = HttpUtil.get(request, "planId", 0);
		// 정렬 방식
		String listType = HttpUtil.get(request, "listType", "");
		// 조회 항목(1: 작성자, 2:제목, 3:내용)
		String searchType = HttpUtil.get(request, "searchType", "");
		// 조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		// 현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		Editor editor = null;
		
		if(planId > 0)
		{
			editor = editorService.editorSelect(planId);
		}
		
		model.addAttribute("planId", planId);
		model.addAttribute("listType", listType);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("editor", editor);
		
		return "/editor/planview";
	}
	
	

}
