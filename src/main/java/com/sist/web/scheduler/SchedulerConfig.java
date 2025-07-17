	package com.sist.web.scheduler;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import com.sist.web.service.OrderService;

@Configuration
@EnableScheduling
public class SchedulerConfig {
    // 스케줄링 활성화
}