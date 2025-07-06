package com.sist.web.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.sist.web.model.Notice;


@Repository("noticeDao")
public interface NoticeDao {

    // 공지사항 페이징 목록
    List<Notice> selectNoticeList(@Param("startRow") int startRow, @Param("pageSize") int pageSize);

    // 전체 공지사항 개수
    int countNotice();

    // 공지사항 상세
    Notice selectNoticeById(String noticeId);

    // 조회수 증가
    void increaseNoticeCount(String noticeId);

    // 공지사항 등록
    void insertNotice(Notice notice);

    // 공지사항 수정
    void updateNotice(Notice notice);

    // 공지사항 삭제
    void deleteNotice(String noticeId);
}
