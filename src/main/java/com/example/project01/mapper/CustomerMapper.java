package com.example.project01.mapper;

import com.example.project01.dto.CustomerTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CustomerMapper {

    String joinCheck(CustomerTO to);
    int userInsert(CustomerTO to);
    Integer userCheck(CustomerTO to);
    CustomerTO selectUserData(CustomerTO to);

}
