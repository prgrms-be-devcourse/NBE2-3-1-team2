package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;

@Alias(value = "pcTO")
@Getter
@Setter
@ToString
public class PurchaseTO {

    private String pid;
    private String cid;
    private Timestamp ot;
    private Timestamp sst;
    private String addr;
    private String zip;
    private String st;
}
