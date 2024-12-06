package com.example.project01.mapper;

import com.example.project01.dto.CustomerTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface CustomerMapper {
    int customer_register(CustomerTO customerTO);
    Integer customer_emailCHK(String email);
    int customer_pwdCHK(CustomerTO customerTO);

    // customer defualt 정보 받아오기
    CustomerTO customer_info(String email);
}
