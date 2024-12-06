package com.example.project01.dao;

import com.example.project01.dto.CustomerTO;
import com.example.project01.mapper.CustomerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CustomerDAO {

    @Autowired
    private CustomerMapper customerMapper;

    public boolean login(CustomerTO to) {
        return customerMapper.login(to);
    }


    public int register(CustomerTO to) {
        return customerMapper.register(to);
    }

    public boolean emailCheck (String email) {

        return customerMapper.emailCheck(email);
    }

    public Integer findCid(String email) {
        return customerMapper.findCid(email);
    }


}
