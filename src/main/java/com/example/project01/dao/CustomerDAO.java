package com.example.project01.dao;

import com.example.project01.dto.CustomerTO;
import com.example.project01.mapper.CustomerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CustomerDAO {

    @Autowired
    private CustomerMapper custormerMapper;


    public int register(CustomerTO to) {
        return custormerMapper.register(to);
    }

    public boolean emailCheck (String email) {

        return custormerMapper.emailCheck(email);
    }


}
