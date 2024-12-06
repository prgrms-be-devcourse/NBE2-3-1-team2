package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@ToString
@Alias("detail")
public class PurchaseDetailTO {
    private int pid;
    private int cid;
    private int prd_id;
    private int qty; // 개수
    private int price;
}
