package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@ToString
@Alias(value = "pdto")
public class PurchaseDetailDTO {
    private int pid;
    private int cid;
    private int prdId;
    private int qty;
    private int price;
}
