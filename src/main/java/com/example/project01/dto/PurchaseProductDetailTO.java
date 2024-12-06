package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@ToString
@Alias("product_detail")
public class PurchaseProductDetailTO extends PurchaseDetailTO{
    private String cat;
    private String name;
    private String img;
}
