package com.example.project01.dao;

import com.example.project01.dto.CustomerTO;
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

    public boolean loginAuth(CustomerTO customer) {
        return customerMapper.authAccount(customer) >= 1;
    }

    public CustomerTO getCustomerByEmail(String email) {
        return customerMapper.selectByEmail(email);
    }
}
