package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@ToString
@Alias(value="cartItem")
public class CartItem {
    private String name;
    private String pid;
    private int count;
    private int price;
}
