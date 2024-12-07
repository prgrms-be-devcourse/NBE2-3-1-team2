package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Alias(value = "purchase")
@Getter
@Setter
public class PurchaseTO {
    private int pid;
    private int cid;
    private String ot;
    private String sst;
    private String zip;
    private String addr;
    private String st;
}
