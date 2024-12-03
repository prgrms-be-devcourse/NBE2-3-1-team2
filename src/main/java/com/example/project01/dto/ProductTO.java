package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Alias(value = "product")
@Getter
@Setter
public class ProductTO {
    private int pid;
    private String img;
    private String name;
    private String stk;
    private int cat;
    private int price;
}
