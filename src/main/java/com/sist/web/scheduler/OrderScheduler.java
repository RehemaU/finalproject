package com.sist.web.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.sist.web.service.OrderService;

@Component
public class OrderScheduler {

	@Autowired
	private OrderService orderService;


	@Scheduled(cron = "0 0 * * * *")
	public void deleteExpiredReservations() {
	    System.out.println("[스케줄러] 실행됨: " + new java.util.Date());
	    orderService.deleteExpiredOrders("W");
	    orderService.deleteExpiredOrders("F");
	}
}