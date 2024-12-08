package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
@ToString
@Alias("join_detail")
public class PurchaseJoinDetailTO {
    private int pid;
    private LocalDate ot;
    private int qty; // 개수
    private int price;
}
