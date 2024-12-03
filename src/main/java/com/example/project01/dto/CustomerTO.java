package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Alias(value = "costomer")
@Getter
@Setter
public class CustomerTO {

    private String cid;
    private String email;
    private String pwd;
    private String addr;
    private String zip;
}
