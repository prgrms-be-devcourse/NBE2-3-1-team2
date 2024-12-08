package com.example.project01.dao;

import com.example.project01.dto.CustomerTO;
import com.example.project01.mapper.AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDAO {

    private final AdminMapper adminMapper;

    @Autowired
    public AdminDAO(AdminMapper adminMapper) {
        this.adminMapper = adminMapper;
    }

    public boolean loginAuth(CustomerTO customer) {
        return adminMapper.authAdmin(customer) > 0;
    }
}
