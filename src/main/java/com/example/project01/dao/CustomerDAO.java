package com.example.project01.dao;

import com.example.project01.mapper.CustomerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CustomerDAO {
    CustomerMapper customerMapper;

    @Autowired
    public CustomerDAO(CustomerMapper customerMapper) {
        this.customerMapper = customerMapper;
    }
}
