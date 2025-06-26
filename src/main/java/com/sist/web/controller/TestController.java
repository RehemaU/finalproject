package com.sist.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {

    @GetMapping("/event/coupontest")
    public String issueCouponTestPage() {
        return "coupontest";  // => /WEB-INF/views/coupontest.jsp
    }
}