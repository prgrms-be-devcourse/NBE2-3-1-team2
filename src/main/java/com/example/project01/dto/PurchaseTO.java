package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@ToString
@Alias(value="purchase")
public class PurchaseTO {
    private Integer cid;
    private int pid;
    private Timestamp ot;
    private Timestamp sst;
    private String zip;
    private String addr;
    private String st;

    private List<CartItem> cart;
    private String email;
}
