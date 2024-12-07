package com.example.project01.mapper;

import com.example.project01.dto.CustomerTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CustomerMapper {
    int authAccount(CustomerTO customer);
    CustomerTO selectByEmail(String email);
    int insertCustomer(CustomerTO customer);
    int deleteCustomer(CustomerTO customer);
    int updateCustomer(CustomerTO customer);
}