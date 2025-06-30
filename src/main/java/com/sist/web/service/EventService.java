package com.sist.web.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.CouponDao;
import com.sist.web.dao.EventDao;
import com.sist.web.dao.UserCouponDao;
import com.sist.web.model.Coupon;
import com.sist.web.model.Event;
import com.sist.web.model.UserCoupon;
import javax.sql.DataSource; // 꼭 필요
import java.sql.Connection;
import org.springframework.jdbc.datasource.DataSourceUtils;


@Service("eventService")
public class EventService {

    private static final Logger logger = LoggerFactory.getLogger(EventService.class);

    @Autowired
    private EventDao eventDao;

 
    
    @Autowired
    private UserCouponDao userCouponDao;

    @Autowired
    private CouponDao couponDao;

    @Autowired
    private DataSource dataSource;
    
    public boolean issueCoupon(String eventId, String userId) {
        logger.debug(">>> issueCoupon 시작 - eventId: {}, userId: {}", eventId, userId);
        
        try {
            Connection conn = DataSourceUtils.getConnection(dataSource);
            String dbUser = conn.getMetaData().getUserName();
            logger.debug("현재 접속한 DB 유저: {}", dbUser);
            logger.debug("현재 접속한 DB URL: {}", conn.getMetaData().getURL());
        } catch (Exception e) {
            logger.error("DB 유저명 확인 중 오류 발생", e);
        }
        
        int eventCountTotal = eventDao.countEvent();
        logger.debug("T_EVENT 전체 개수: {}", eventCountTotal);
        
        // 1. 이벤트 조회
        Event event = eventDao.selectEventById(eventId);
        logger.debug("eventDao.selectEventById() 결과 null 여부: {}", event == null);
        if (event == null) {
            logger.debug("이벤트 정보 없음: eventId = {}", eventId);
            return false;
        }

        // 로그로 전체 이벤트 객체 찍기
        logger.debug("조회된 이벤트 객체: {}", event);

     // 2. 쿠폰 ID 확인 (전체 필드 디버깅)
        logger.debug("===== 이벤트 전체 필드 디버깅 =====");
        logger.debug("event.getEventId(): {}", event.getEventId());
        logger.debug("event.getAdminId(): {}", event.getAdminId());
        logger.debug("event.getCouponId(): {}", event.getCouponId());
        logger.debug("event.getEventTitle(): {}", event.getEventTitle());
        logger.debug("event.getEventContent(): {}", event.getEventContent());
        logger.debug("event.getEventRegdate(): {}", event.getEventRegdate());
        logger.debug("event.getEventCount(): {}", event.getEventCount());
        logger.debug("event.getCouponId(): {}", event.getCouponId());
        logger.debug("===== 쿠폰 ID 상세 디버깅 =====");
        String couponId = event.getCouponId();
        logger.debug("eventId: {}, userId: {}", eventId, userId);
        logger.debug("couponId 원본 값: [{}]", couponId);
        logger.debug("couponId == null ? {}", couponId == null);
        logger.debug("\"\".equals(couponId) ? {}", "".equals(couponId));
        logger.debug("===============================");

        if (couponId == null || couponId.trim().isEmpty()) {
            logger.debug("이벤트에 연결된 쿠폰 ID 없음 (null or empty): eventId = {}", eventId);
            return false;
        }

        logger.debug("이벤트 연결 쿠폰 ID: {}", couponId);

        // 3. 기존 발급 여부 확인
        int existCount = userCouponDao.existsUserCoupon(userId, couponId);
        logger.debug("기존 발급 여부 수: {}", existCount);
        if (existCount > 0) {
            logger.debug("이미 해당 쿠폰을 발급받음: userId = {}, couponId = {}", userId, couponId);
            return false;
        }

        // 4. 쿠폰 정보 조회
        Coupon coupon = couponDao.selectCouponById(couponId);
        if (coupon == null) {
            logger.debug("쿠폰 정보 없음: couponId = {}", couponId);
            return false;
        }

        logger.debug("쿠폰 정보 조회됨: {}", coupon);
        logger.debug("쿠폰 수량: {}", coupon.getCouponCount());
        logger.debug("쿠폰 만료일 기준일수: {}", coupon.getCouponExpiredate());

        if (coupon.getCouponCount() <= 0) {
            logger.debug("쿠폰 수량 부족: count = {}", coupon.getCouponCount());
            return false;
        }

        // 5. 날짜 처리
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String issueDateStr = sdf.format(new Date());

        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.add(Calendar.DATE, coupon.getCouponExpiredate());
        String expirDateStr = sdf.format(cal.getTime());

        // 6. UserCoupon 객체 생성
        UserCoupon userCoupon = new UserCoupon();
        userCoupon.setUserId(userId);
        userCoupon.setCouponId(couponId);
        userCoupon.setUserCouponName(coupon.getCouponName());
        userCoupon.setUserCouponIssueday(issueDateStr);
        userCoupon.setUserCouponUse("N");
        userCoupon.setUserCouponExpiredate(expirDateStr);

        logger.debug("UserCoupon insert 준비: {}", userCoupon);

        // 7. 인서트 + 수량 차감
        try {
            userCouponDao.insertUserCoupon(userCoupon);
            couponDao.decreaseCouponCount(couponId);
            logger.debug("쿠폰 발급 및 수량 차감 완료: couponId = {}", couponId);
        } catch (Exception e) {
            logger.error("쿠폰 발급 또는 수량 차감 중 오류 발생", e);
            return false;
        }

        
        
        
        return true;
    }
    
    public List<Event> getActiveEvents() {
        return eventDao.selectActiveEvents();
    }

    // 종료된 이벤트 조회
    public List<Event> getEndedEvents() {
        return eventDao.selectEndedEvents();
    }
    
    
    public Event getEventById(String eventId) {
        return eventDao.selectEventById(eventId);
    }

    public void increaseEventCount(String eventId) {
        eventDao.increaseEventCount(eventId);
    }
    
    
}
