package com.sist.web.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sist.web.model.Calander;
import com.sist.web.model.CalanderList;
import com.sist.web.model.Region;
import com.sist.web.model.Sigungu;
import com.sist.web.service.CalanderService;
import com.sist.web.service.RegionService;
import com.sist.web.service.SigunguService;

@Controller("calanderController")
public class CalanderController {

    @Autowired
    private CalanderService calanderService;

    @Autowired
    private RegionService regionService;

    @Autowired
    private SigunguService sigunguService;

    /* ① 지역 및 시군구 목록 주입 (addList.jsp 진입 시) */
    @GetMapping("/schedule/addList")
    public String addListForm(ModelMap model, HttpSession session) {
        String userId = (String) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/user/login"; // 로그인 안됐으면 로그인 페이지로
        }

        List<Region> regionList = regionService.getAllRegions();
        List<Sigungu> sigunguList = sigunguService.getAllSigungus();
        model.addAttribute("regionList", regionList);
        model.addAttribute("sigunguList", sigunguList);
        return "/schedule/addList";
    }

    /* ② 사용자가 일정 이름, 날짜, 지역 선택 후 저장 */
    @PostMapping("/schedule/saveList")
    public String saveList(HttpServletRequest request, HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login";
        }
    	
        String listName = request.getParameter("listName");
        String selectedDatesJson = request.getParameter("selectedDates");

        String regionId = request.getParameter("regionId");
        String sigunguId = request.getParameter("sigunguId");

        try {
            List<String> selectedDates = new Gson()
                .fromJson(selectedDatesJson, new TypeToken<List<String>>() {}.getType());

            String listId = UUID.randomUUID().toString();
            Date startDate = java.sql.Date.valueOf(selectedDates.get(0));
            Date endDate = java.sql.Date.valueOf(selectedDates.get(selectedDates.size() - 1));

            CalanderList vo = new CalanderList(listId, userId, listName, startDate, endDate);


            calanderService.saveList(vo);

            session.setAttribute("currentListId", listId);
            session.setAttribute("selectedDates", selectedDates);
            session.setAttribute("listName", listName);
            session.setAttribute("calanderListId", listId);
            session.setAttribute("regionId", regionId);
            session.setAttribute("sigunguId", sigunguId);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/schedule/addDetail";
    }

    /* ③ 상세 일정 추가 화면 (addDetail.jsp 진입 시 지역 리스트 전달) */
    @GetMapping("/schedule/addDetail")
    public String addDetailForm(ModelMap model) {
        model.addAttribute("regionList", regionService.getAllRegions());
        model.addAttribute("sigunguList", sigunguService.getAllSigungus());
        return "/schedule/addDetail";
    }

    /* ④ 상세 일정 저장 (장소, 시간, Day 정보 포함) */
    @PostMapping("/schedule/saveDetail")
    public String saveDetail(HttpServletRequest request, HttpSession session) {
        String[] spotIds = request.getParameterValues("spotIds");
        String[] startTimes = request.getParameterValues("startTimes");
        String[] endTimes = request.getParameterValues("endTimes");
        String[] dayNos = request.getParameterValues("dayNos");
        
        // 수동 추가된 주소 정보들
        String[] manualNames = request.getParameterValues("manualNames");
        String[] manualAddresses = request.getParameterValues("manualAddresses");
        String[] manualLats = request.getParameterValues("manualLats");
        String[] manualLons = request.getParameterValues("manualLons");

        String listId = (String) session.getAttribute("currentListId");

        if (spotIds == null || startTimes == null || endTimes == null || dayNos == null) {
            System.out.println("🚨 필수 파라미터 누락");
            return "redirect:/schedule/addDetail";
        }

        try {
            int manualIndex = 0; // 수동 추가 데이터의 인덱스
            
            for (int i = 0; i < spotIds.length; i++) {
                String spotId = spotIds[i];
                Date st = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(startTimes[i]);
                Date et = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(endTimes[i]);
                int dayNo = Integer.parseInt(dayNos[i]);

                // 수동 추가된 주소인지 확인
                if ("MANUAL_ADDRESS".equals(spotId)) {
                    if (manualNames != null && manualIndex < manualNames.length) {
                        // 수동 추가된 주소의 경우 별도 처리
                        String manualName = manualNames[manualIndex];
                        String manualAddress = manualAddresses[manualIndex];
                        String manualLat = manualLats[manualIndex];
                        String manualLon = manualLons[manualIndex];
                        
                        // 수동 주소는 특별한 spotId 생성 (이름과 좌표 조합)
                        String uniqueSpotId = "MANUAL_" + manualName.replaceAll("\\s+", "_") + 
                                             "_" + manualLat + "_" + manualLon;
                        
                        System.out.println("📍 수동 추가 주소 저장: " + manualName + " at " + manualAddress);
                        
                        Calander cal = new Calander(
                            UUID.randomUUID().toString(),
                            listId,
                            uniqueSpotId, // 고유한 수동 주소 ID 사용
                            st,
                            et,
                            dayNo
                        );
                        calanderService.saveDetail(cal);
                        manualIndex++;
                    } else {
                        System.out.println("🚨 수동 주소 데이터 부족: manualIndex=" + manualIndex);
                    }
                } else {
                    // 기존 숙소/관광지 저장 로직
                    Calander cal = new Calander(
                        UUID.randomUUID().toString(),
                        listId,
                        spotId,
                        st,
                        et,
                        dayNo
                    );
                    calanderService.saveDetail(cal);
                }
            }
            
            System.out.println("✅ 총 " + spotIds.length + "개 일정 저장 완료 (수동 주소 " + manualIndex + "개 포함)");
            
        } catch (Exception e) {
            System.out.println("🚨 일정 저장 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
        }

        return "redirect:/schedule/list";
    }

    /* ⑤ 일정 수정 저장 컨트롤러도 동일하게 수정 */
    @PostMapping("/schedule/updateDetail")
    public String updateDetail(HttpServletRequest request, HttpSession session) {
        String[] calIds = request.getParameterValues("calanderIds");
        String[] spotIds = request.getParameterValues("spotIds");
        String[] startTimes = request.getParameterValues("startTimes");
        String[] endTimes = request.getParameterValues("endTimes");
        String[] dayNos = request.getParameterValues("dayNos");
        
        // 수동 추가된 주소 정보들
        String[] manualNames = request.getParameterValues("manualNames");
        String[] manualAddresses = request.getParameterValues("manualAddresses");
        String[] manualLats = request.getParameterValues("manualLats");
        String[] manualLons = request.getParameterValues("manualLons");

        String listId = (String) session.getAttribute("calanderListId");

        if (spotIds == null || startTimes == null || endTimes == null || dayNos == null) {
            System.out.println("🚨 수정 저장 시 필수 파라미터 누락");
            return "redirect:/schedule/editForm?listId=" + listId;
        }

        try {
            calanderService.deleteDetailsByListId(listId); // 기존 일정 삭제 후
            
            int manualIndex = 0; // 수동 추가 데이터의 인덱스

            for (int i = 0; i < spotIds.length; i++) {
                String spotId = spotIds[i];
                Date st = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(startTimes[i]);
                Date et = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(endTimes[i]);
                int dayNo = Integer.parseInt(dayNos[i]);

                // 수동 추가된 주소인지 확인
                if ("MANUAL_ADDRESS".equals(spotId)) {
                    if (manualNames != null && manualIndex < manualNames.length) {
                        String manualName = manualNames[manualIndex];
                        String manualAddress = manualAddresses[manualIndex];
                        String manualLat = manualLats[manualIndex];
                        String manualLon = manualLons[manualIndex];
                        
                        String uniqueSpotId = "MANUAL_" + manualName.replaceAll("\\s+", "_") + 
                                             "_" + manualLat + "_" + manualLon;
                        
                        Calander cal = new Calander(
                            UUID.randomUUID().toString(),
                            listId,
                            uniqueSpotId,
                            st,
                            et,
                            dayNo
                        );
                        calanderService.saveDetail(cal);
                        manualIndex++;
                    }
                } else {
                    // 기존 숙소/관광지 저장 로직
                    Calander cal = new Calander(
                        UUID.randomUUID().toString(),
                        listId,
                        spotId,
                        st,
                        et,
                        dayNo
                    );
                    calanderService.saveDetail(cal);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/schedule/list";
    }

    /* ⑤ 일정 전체 리스트 보기 */
    @GetMapping("/schedule/list")
    public String scheduleList(ModelMap model, HttpSession session) {
        String listId = (String) session.getAttribute("currentListId");
        List<Calander> calList = calanderService.getCalanders(listId);
        model.addAttribute("calList", calList);
        return "/schedule/scheduleList";
    }
    @GetMapping("/schedule/view")
    public String viewSchedule(@RequestParam("listId") String listId,
                               ModelMap model,
                               HttpSession session) {

        CalanderList list   = calanderService.getListById(listId);
        List<Calander> cals = calanderService.getCalanders(listId);

        session.setAttribute("currentListId", listId);  // 이후에도 재활용
        model.addAttribute("list", list);
        model.addAttribute("calList", cals);

        return "/schedule/scheduleList";                // 동일 뷰 재사용
    }
    /* ⑥ (옵션) 메뉴 전용 진입 */
    @GetMapping("/schedule/menu")
    public String scheduleMenu() {
        return "/schedule/menu";
    }
 // ✅ 일정 수정 화면 진입 + 기존 일정 정보 조회용 컨트롤러
    @GetMapping("/schedule/editForm")
    public String editForm(@RequestParam("listId") String listId, ModelMap model, HttpSession session) {
        CalanderList list = calanderService.getListById(listId);
        List<Calander> calList = calanderService.getCalanders(listId);

        model.addAttribute("list", list);
        model.addAttribute("calList", calList);
        model.addAttribute("regionList", regionService.getAllRegions());
        model.addAttribute("sigunguList", sigunguService.getAllSigungus());

        session.setAttribute("calanderListId", listId); // 이후 저장 시 재사용

        return "/schedule/editForm";
    }
    @PostMapping("/schedule/deleteList")
    public String deleteSchedule(@RequestParam("listId") String listId, HttpSession session) {
        try {
            // 1. 상세 일정 먼저 삭제
            calanderService.deleteDetailsByListId(listId);

            // 2. 일정 리스트 자체 삭제 (이 부분만 새로 추가되면 됨)
            calanderService.deleteListById(listId);

            // 3. 세션에서 일정 관련 정보 제거
            session.removeAttribute("calanderListId");
            session.removeAttribute("listName");
            session.removeAttribute("selectedDates");

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/schedule/list?error=delete";
        }

        return "redirect:/schedule/addList";
    }
    @GetMapping("/schedule/myList")
    public String myList(ModelMap model, HttpSession session){
        String userId = (String)session.getAttribute("userId");
        if(userId == null){          // 로그인 안됐을 때 처리
            return "redirect:/user/login";
        }
        List<CalanderList> lists = calanderService.getListsByUser(userId);
        model.addAttribute("lists", lists);
        return "/schedule/calList";   // ↓ JSP 파일명
    }
}
