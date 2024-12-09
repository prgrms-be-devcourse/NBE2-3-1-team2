package com.example.project01.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@ToString
@AllArgsConstructor
@Alias(value = "pdto")
public class PurchaseDetailDTO {
    private int pid;
    private int prd_id;
    private int cid;
    private int qty;
    private int price;
}
