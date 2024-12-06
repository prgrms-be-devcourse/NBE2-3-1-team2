package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@ToString
@Alias("product")
public class ProductTO {
    private int pid;
    private String img;
    private String name;
    private String cat;
    private int stk;
    private int price;
}