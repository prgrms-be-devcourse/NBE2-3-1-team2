package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PurchaseDetailTO {
    private int pid;
    private int cid;
    private int prd_id;
    private int qty;
    private double price;
}
