package com.sist.web.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.sist.web.model.Admin;
import com.sist.web.model.Seller;
import com.sist.web.model.User;

public interface AdminDao {
	Admin selectAdminById(String adminId);
	
	// 판매자 전체 조회
	public List<Seller> sellerList();

	// 판매자 승인 처리
	public int approveSeller(String sellerId);
	
	
//    // ✅ 페이징/검색 포함한 판매자 리스트 조회
//    public List<Seller> getSellerList(Map<String, Object> param);

    // ✅ 판매자 수 조회 (검색 포함)
    public int getSellerCount(String keyword);
    
    int updateSellerStatus(Map<String, Object> param);
    
    public List<User> getAllUsers();  
    int updateUserStatus(@Param("userId") String userId, @Param("status") String status);
    
    public List<User> searchUsersById(String keyword);
    
    public List<User> getUsersWithPaging(Map<String, Object> param);
    int getUserCount(Map<String, Object> param);
    
    public List<Seller> getSellerList(Map<String, Object> param);
    int getSellerCount(Map<String, Object> param);
    
    
    List<Map<String, Object>> getAccommList(Map<String, Object> param);
    int getAccommCount(Map<String, Object> param);
    int approveAccomm(String accommId);
    
    public List<Map<String,Object>> getReviewList(Map<String,Object> param);
    public int getReviewCount(Map<String,Object> param);
    
}
