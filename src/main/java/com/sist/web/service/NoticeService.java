package com.sist.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.NoticeDao;
import com.sist.web.model.Notice;


@Service("noticeService")
public class NoticeService {

	
	@Autowired
	private NoticeDao noticeDao;
	
	
	public List<Notice> getNoticeList(int startRow, int pageSize) {
	    return noticeDao.selectNoticeList(startRow, pageSize);
	}
	
	public int getNoticeCount() {
        return noticeDao.countNotice();
    }
	
	
}
