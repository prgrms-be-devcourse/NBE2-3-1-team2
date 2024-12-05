package com.example.project01.dao;

import com.example.project01.dto.CustomerTO;
import com.example.project01.mapper.CustomerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public class CustomerDAO {
    @Autowired
    private CustomerMapper customerMapper;

    public int customerRegister(CustomerTO customerTO) {
        // return 에서 @Autowired 로 주입한 것을 사용해야함
        return customerMapper.customer_register(customerTO);
    }

    // 이메일 확인
    public int emailCheck(String email) {
        Integer result =  customerMapper.customer_emailCHK(email);
        return result != null ? result : -1;
    }

    public boolean passwordCheck(CustomerTO customerTO) {
        return customerMapper.customer_pwdCHK(customerTO) > 0;
    }
}
