package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Alias(value = "product")
@Getter
@Setter
public class ProductTO {
    // database table 형 확인 필수
    private int pid;
    private String img;
    private String name;
    private String cat;
    private int stk;
    private int price;
}
