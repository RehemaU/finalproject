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
    public String addListForm(ModelMap model) {
        List<Region> regionList = regionService.getAllRegions();
        List<Sigungu> sigunguList = sigunguService.getAllSigungus();
        model.addAttribute("regionList", regionList);
        model.addAttribute("sigunguList", sigunguList);
        return "/schedule/addList";
    }

    /* ② 사용자가 일정 이름, 날짜, 지역 선택 후 저장 */
    @PostMapping("/schedule/saveList")
    public String saveList(HttpServletRequest request, HttpSession session) {
        String listName = request.getParameter("listName");
        String selectedDatesJson = request.getParameter("selectedDates");

        String regionId = request.getParameter("regionId");
        String sigunguId = request.getParameter("sigunguId");

        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            userId = "test";
            session.setAttribute("userId", userId);
        }

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

        String listId = (String) session.getAttribute("currentListId");

        if (spotIds == null || startTimes == null || endTimes == null || dayNos == null) {
            System.out.println("🚨 필수 파라미터 누락");
            return "redirect:/schedule/addDetail";
        }

        try {
            for (int i = 0; i < spotIds.length; i++) {
                String spotId = spotIds[i];
                Date st = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(startTimes[i]);
                Date et = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(endTimes[i]);
                int dayNo = Integer.parseInt(dayNos[i]);

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

    /* ⑥ (옵션) 메뉴 전용 진입 */
    @GetMapping("/schedule/menu")
    public String scheduleMenu() {
        return "/schedule/menu";
    }
}
