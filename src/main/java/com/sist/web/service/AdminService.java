package com.sist.web.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.AdminDao;
import com.sist.web.model.Admin;

@Service("adminService") 
public class AdminService {

    @Autowired
    private AdminDao adminDao;	

    public Admin getAdminById(String adminId) {
        return adminDao.selectAdminById(adminId);
    }

   
}