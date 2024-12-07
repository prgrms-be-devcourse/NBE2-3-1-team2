package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Alias(value = "purchaseDetail")
@Getter
@Setter
public class PurchaseDetailTO {
    private int pid;
    private int cid;
    private int prd_id;
    private int qty;
    private double price;
}
