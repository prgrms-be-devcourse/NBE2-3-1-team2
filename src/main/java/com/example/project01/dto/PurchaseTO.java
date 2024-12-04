package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PurchaseTO {
    private int pid;
    private int cid;
    private String dt;
    private String zip;
    private String addr;
    private String st;
}
