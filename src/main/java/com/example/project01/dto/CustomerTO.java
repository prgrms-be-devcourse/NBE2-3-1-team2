package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Alias(value = "cTO")
@Getter
@Setter
public class CustomerTO {

    private String cid;
    private String email;
    private String pwd;
    private String addr;
    private String zip;
    // 회원가입 여부 체크 ( 사용 보류 )
//    private String joinCk;
}
