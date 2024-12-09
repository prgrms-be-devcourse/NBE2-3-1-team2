package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;
import java.util.List;

@Getter
@Setter
@ToString
@Alias(value="history")
public class PurchaseHistoryTO {
    private int pid;
    private Timestamp ot;
    private Timestamp sst;
    private String zip;
    private String addr;
    private String st;
    private String prd_id;
    private int qty;
    private int price;
    private String img;
}
