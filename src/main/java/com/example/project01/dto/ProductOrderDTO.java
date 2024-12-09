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
@Alias(value = "poto")
public class ProductOrderDTO {
    private int pid;
    private int prd_id;
    private LocalDateTime ot;
    private LocalDate sst;
    private String zip;
    private String addr;
    private int qty;
    private int price;
    private int st;
}
