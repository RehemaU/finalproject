package com.sist.web.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.sist.web.model.Like;

public interface LikeDao {
    void insertLike(@Param("userId") String userId,
            @Param("spotId") String spotId);

void deleteLike(@Param("userId") String userId,
            @Param("spotId") String spotId);

int  existsLike(@Param("userId") String userId,
            @Param("spotId") String spotId);
List<Map<String, Object>> getLikedSpots(String userId);

}

