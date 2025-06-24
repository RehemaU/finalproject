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
import com.sist.web.service.CalanderService;

@Controller("calanderController")
public class CalanderController {

    @Autowired
    private CalanderService calanderService;

    @RequestMapping(value = "/schedule/addList", method = RequestMethod.GET)
    public String addListForm() {
        return "/schedule/addList";
    }

    @RequestMapping(value = "/schedule/saveList", method = RequestMethod.POST)
    public String saveList(HttpServletRequest request, HttpSession session) {
        String listName = request.getParameter("listName");
        String selectedDatesJson = request.getParameter("selectedDates");

        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            userId = "test";
            session.setAttribute("userId", userId);
        }

        try {
            List<String> selectedDates = new Gson().fromJson(selectedDatesJson, new TypeToken<List<String>>() {}.getType());

            String listId = UUID.randomUUID().toString();
            Date startDate = java.sql.Date.valueOf(selectedDates.get(0));
            Date endDate = java.sql.Date.valueOf(selectedDates.get(selectedDates.size() - 1));

            CalanderList vo = new CalanderList(listId, userId, listName, startDate, endDate);
            calanderService.saveList(vo);

            session.setAttribute("currentListId", listId);
            session.setAttribute("selectedDates", selectedDates);
            session.setAttribute("listName", listName);
            session.setAttribute("calanderListId", listId);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/schedule/addDetail";
    }

    @RequestMapping(value = "/schedule/addDetail", method = RequestMethod.GET)
    public String addDetailForm() {
        return "/schedule/addDetail";
    }

    @RequestMapping(value = "/schedule/saveDetail", method = RequestMethod.POST)
    public String saveDetail(HttpServletRequest request, HttpSession session) {
        String[] spotIds = request.getParameterValues("spotIds[]");
        String[] startTimes = request.getParameterValues("startTimes[]");
        String[] endTimes = request.getParameterValues("endTimes[]");

        String listId = (String) session.getAttribute("currentListId");

        if (spotIds == null || startTimes == null || endTimes == null) {
            System.out.println("🚨 필수 파라미터 누락");
            return "redirect:/schedule/addDetail";
        }

        try {
            for (int i = 0; i < spotIds.length; i++) {
                // ⭐️ 여기서 String -> int로 변환
            	String spotId = spotIds[i];

                Date startTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(startTimes[i]);
                Date endTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(endTimes[i]);

                Calander cal = new Calander(UUID.randomUUID().toString(), listId, spotId, startTime, endTime);
                calanderService.saveDetail(cal);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/schedule/list";
    }


    @RequestMapping(value = "/schedule/list", method = RequestMethod.GET)
    public String scheduleList(ModelMap model, HttpSession session) {
        String listId = (String) session.getAttribute("currentListId");
        List<Calander> calList = calanderService.getCalanders(listId);
        model.addAttribute("calList", calList);
        return "/schedule/scheduleList";
    }
    
    
    
}
