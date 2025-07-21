package com.sist.web.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.AdminDao;
import com.sist.web.dao.SellerDao;
import com.sist.web.model.Admin;
import com.sist.web.model.Seller;
import com.sist.web.model.User;

@Service("adminService") 
public class AdminService {
	private static Logger logger = LoggerFactory.getLogger(AdminService.class);
    @Autowired
    private AdminDao adminDao;	
    
 

    public Admin getAdminById(String adminId) {
        return adminDao.selectAdminById(adminId);
    }
    
 // 판매자 전체 목록 조회
 	public List<Seller> sellerList() {
 	    List<Seller> list = null;
 	    try {
 	        list = adminDao.sellerList();
 	    } catch (Exception e) {
 	        logger.error("[AdminService]sellerList Exception", e);
 	    }
 	    return list;
 	}

 	// 판매자 승인 처리
 	public int approveSeller(String sellerId) {
 	    int count = 0;
 	    try {
 	        count = adminDao.approveSeller(sellerId);
 	    } catch (Exception e) {
 	        logger.error("[AdminService]approveSeller Exception", e);
 	    }
 	    return count;
 	}
 	public int updateSellerStatus(Map<String, Object> param) {
 	    int count = 0;
 	    try {
 	        count = adminDao.updateSellerStatus(param);
 	    } catch (Exception e) {
 	        logger.error("[AdminService]updateSellerStatus Exception", e);
 	    }
 	    return count;
 	}
 	
 	//유
 	public List<User> getAllUsers() {
 	    return adminDao.getAllUsers(); // DAO에서 전체 사용자 조회
 	}
 	
 	public boolean updateUserStatus(String userId, String status) {
 	    int result = adminDao.updateUserStatus(userId, status);
 	    return result > 0;
 	}
   
 	public List<User> searchUsersById(String keyword) {
 	    return adminDao.searchUsersById(keyword);
 	}
 	
 	public List<User> getUsersWithPaging(Map<String, Object> param) {
 	    return adminDao.getUsersWithPaging(param);
 	}
 	
 	public int getUserCount(Map<String, Object> param) {
 	    return adminDao.getUserCount(param);
 	}

 	
    public List<Seller> getSellerList(Map<String, Object> param) {
        return adminDao.getSellerList(param);
    }
    public int getSellerCount(Map<String, Object> param) {
        return adminDao.getSellerCount(param);
    }
    
    public List<Map<String, Object>> getAccommList(Map<String, Object> param) {
        return adminDao.getAccommList(param);
    }
    
    public int getAccommCount(Map<String, Object> param) {
        return adminDao.getAccommCount(param);
    }
    
    public boolean approveAccomm(String accommId) {
        return adminDao.approveAccomm(accommId) > 0;
    }
    
    public List<Map<String,Object>> getReviewList(Map<String,Object> param) {
    	return adminDao.getReviewList(param);
    }
    public int getReviewCount(Map<String,Object> param) {
    	return adminDao.getReviewCount(param);
    }
    
    public int updateReviewStatus(int planId, String status) {
        return adminDao.updateReviewStatus(planId, status); // DAO 호출
    }
    
    
    
}