package com.sist.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sist.web.dao.LikeDao;
import com.sist.web.model.Like;

@Service
public class LikeService {

    @Autowired
    private LikeDao likeDao;

    /** true → 정상 insert, false → 이미 존재 */
    @Transactional
    public boolean addLike(String userId, String spotId) {
        if (likeDao.existsLike(userId, spotId) > 0) return false;
        likeDao.insertLike(userId, spotId);
        return true;
    }

    @Transactional
    public void removeLike(String userId, String spotId) {
        likeDao.deleteLike(userId, spotId);
    }

    public boolean isLiked(String userId, String spotId) {
        return likeDao.existsLike(userId, spotId) > 0;
    }
    
    public List<Map<String, Object>> getLikedSpots(String userId) {
        return likeDao.getLikedSpots(userId);
    }
}
