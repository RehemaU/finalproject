package com.sist.web.dao;

import com.sist.web.model.Sigungu;
import java.util.List;

public interface SigunguDao {

    // 1. insert (중복 방지 INSERT)
    public void insertSigungu(Sigungu sigungu);

    // 2. 전체 조회
    public List<Sigungu> getAllSigungu();

    // 3. 특정 시도(regionId)의 시군구 목록 조회
    public List<Sigungu> getSigunguByRegionId(String regionId);

    // 4. 존재 여부 확인 (중복 체크용)
    public int existsSigungu(String regionId, String sigunguId);
}
