package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@ToString
@Alias(value="customer")
public class CustomerTO {
    private String cid;
    private String email;
    private String pwd;
    private String addr;
    private String zip;
}
