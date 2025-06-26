package com.sist.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.UserCouponDao;
import com.sist.web.model.UserCoupon;

@Service("userCouponService")
public class UserCouponService {

    @Autowired
    private UserCouponDao userCouponDao;

    // ✅ 특정 유저가 특정 쿠폰을 발급받았는지 확인
    public boolean hasCoupon(String userId, String couponId) {
        return userCouponDao.existsUserCoupon(userId, couponId) > 0;
    }

    // ✅ 유저 쿠폰 발급
    public boolean insertUserCoupon(UserCoupon userCoupon) {
        return userCouponDao.insertUserCoupon(userCoupon) > 0;
    }

    // ✅ 유저가 가진 모든 쿠폰 리스트 조회 (마이페이지용)
    public List<UserCoupon> getUserCouponList(String userId) {
        return userCouponDao.selectUserCouponList(userId);
    }

    // ✅ 특정 유저 쿠폰 상세 조회
    public UserCoupon getUserCouponById(String userCouponId) {
        return userCouponDao.selectUserCouponById(userCouponId);
    }

    // ✅ 쿠폰 사용 처리
    public boolean useCoupon(String userCouponId) {
        return userCouponDao.updateUserCouponUse(userCouponId) > 0;
    }
}