package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@Alias("product")
public class ProductTO {
    private String pid;
    private String img;
    private String name;
    private String cat;
    private String stk;
    private String price;
}