package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@Alias("detail")
public class PurchaseDetailTO {
    private String pid;
    private String cid;
    private String prd_id;
    private String qty; // 개수
    private String price;
}
