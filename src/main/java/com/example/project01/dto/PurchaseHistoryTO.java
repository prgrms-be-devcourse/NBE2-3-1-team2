package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Alias(value = "purchaseHistory")
@Getter
@Setter
public class PurchaseHistoryTO {
    private int customer_id;
    private int purchase_id;
    private String order_time;
    private String image;
    private String category;
    private String product_name;
    private int quantity;
    private int total_price;
    private String delivery_status;
}
