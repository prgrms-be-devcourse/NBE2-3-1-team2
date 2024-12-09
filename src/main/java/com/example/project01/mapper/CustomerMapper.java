package com.example.project01.mapper;

import com.example.project01.dto.CustomerDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface CustomerMapper {
    int isContainEmail(CustomerDTO cto);
    String selectCustomer(CustomerDTO cto);
    int insertCustomer(CustomerDTO cto);
    CustomerDTO selectCustomerById(String cid);
    int deleteCustomer(Map data);
}
