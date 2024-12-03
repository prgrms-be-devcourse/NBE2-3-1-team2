package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@ToString
@Alias(value = "pto")
public class PurchaseDTO {
    private int pid;
    private int cid;
    private String dt;
    private String zip;
    private String addr;
    private String st;
}
