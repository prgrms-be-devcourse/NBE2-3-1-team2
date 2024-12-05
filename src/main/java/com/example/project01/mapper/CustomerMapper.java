package com.example.project01.mapper;

import com.example.project01.dto.CustomerTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface CustomerMapper {
    int customer_register(CustomerTO customerTO);
    int customer_emailCHK(String email);
}
