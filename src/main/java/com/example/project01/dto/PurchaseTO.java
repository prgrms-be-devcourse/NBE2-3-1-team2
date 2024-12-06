package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;

@Getter
@Setter
@ToString
@Alias("purchase")
public class PurchaseTO {
    private int pid;
    private int cid;
    private Timestamp ot;
    private Timestamp sst;
    private String zip;
    private String addr;
    private String st;
}
