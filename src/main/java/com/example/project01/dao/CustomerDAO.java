package com.example.project01.dao;

import com.example.project01.dto.CustomerTO;
import com.example.project01.mapper.CustomerMapper;
import com.example.project01.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;

@Repository
public class CustomerDAO {
    @Autowired
    private CustomerMapper customerMapper;
    @Autowired
    private ProductMapper productMapper;

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

    // email 전달하고 addr, zip 을 to로 전달 받기
    public CustomerTO customerInfo(String email) {
        return customerMapper.customer_info(email);
    }

    public int customerDelete(String email){
        return customerMapper.customer_delete(email);
    }

}
