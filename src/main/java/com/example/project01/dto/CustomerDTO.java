package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@ToString
@Alias(value = "cto")
public class CustomerDTO {
    private int cid;
    private String email;
    private String pwd;
    private String addr;
    private String zip;
}
