package com.example.project01.dao;

import com.example.project01.dto.CustomerDTO;
import com.example.project01.mapper.CustomerMapper;
import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Map;

@Repository
public class CustomerDAO {
    @Autowired
    private CustomerMapper customerMapper;

    public int isContainEmail(CustomerDTO cto) {return customerMapper.isContainEmail(cto);}

    public String selectCustomer(CustomerDTO cto) {return customerMapper.selectCustomer(cto);}

    public int insertCustomer(CustomerDTO cto) {
        int flag = 0;
        try {
            flag = customerMapper.insertCustomer(cto);
        } catch (Exception e) {
            Throwable cause = e.getCause();
            if ( e.getCause() instanceof SQLIntegrityConstraintViolationException ) {
                System.out.println("중복된 이메일입니다.");
                flag = 2;
            } else {
                System.out.println("근본 원인 예외: " + cause.getClass().getName());
                System.out.println("예외 메시지: " + cause.getMessage());
                System.out.println("예외 발생 : " + e.getMessage());
            }
        }
        return flag;
    }

    public CustomerDTO selectCustomerById(String cid) {return customerMapper.selectCustomerById(cid);}

    public int deleteCustomer(Map data) {return customerMapper.deleteCustomer(data);}
}
