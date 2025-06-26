package com.sist.web.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
        String[] spotIds    = request.getParameterValues("spotIds");
        String[] startTimes = request.getParameterValues("startTimes");
        String[] endTimes   = request.getParameterValues("endTimes");
        String[] dayNos     = request.getParameterValues("dayNos");

        String listId = (String) session.getAttribute("currentListId");

        if (spotIds == null || startTimes == null || endTimes == null || dayNos == null) {
            System.out.println("🚨 필수 파라미터 누락");
            return "redirect:/schedule/addDetail";
        }

        try {
            for (int i = 0; i < spotIds.length; i++) {
                String spotId  = spotIds[i];
                Date   st      = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(startTimes[i]);
                Date   et      = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(endTimes[i]);
                int    dayNo   = Integer.parseInt(dayNos[i]);

                // 📌 dayNo를 생성자에서 바로 세팅
                Calander cal = new Calander(
                    UUID.randomUUID().toString(),
                    listId,
                    spotId,
                    st,
                    et,
                    dayNo
                );
                calanderService.saveDetail(cal);
                System.out.println("✅ 일정 저장 진입됨");
                System.out.println("→ spotIds: " + Arrays.toString(spotIds));
                System.out.println("→ startTimes: " + Arrays.toString(startTimes));
                System.out.println("→ endTimes: " + Arrays.toString(endTimes));
                System.out.println("→ dayNos: " + Arrays.toString(dayNos));
                System.out.println("→ listId: " + listId);
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
    
	@RequestMapping(value = "/schedule/menu", method=RequestMethod.GET)
	public String scheduleMenu(HttpServletRequest request, HttpServletResponse response)
	{
		return "/schedule/menu";
	}
    
}
