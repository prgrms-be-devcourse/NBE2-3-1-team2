package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@Alias("purchase")
public class PurchaseTO {
    private String pid;
    private String cid;
    private String dt;
    private String zip;
    private String addr;
    private String st;
}
