package com.example.project01.mapper;

import com.example.project01.dto.CustomerTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CustomerMapper {
    boolean login(CustomerTO to);
    int register(CustomerTO to);
    boolean emailCheck(String email);
    boolean pwdCheck(CustomerTO to);
    int delete(CustomerTO to);

    Integer findCid(String email);
}
