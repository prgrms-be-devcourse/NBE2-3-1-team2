package com.example.project01.mapper;

import com.example.project01.dto.CustomerTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CustomerMapper {

    int register(CustomerTO to);
    boolean emailCheck(String email);
}
