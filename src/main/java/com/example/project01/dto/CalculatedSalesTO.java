package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDate;

@Getter
@Setter
@ToString
public class CalculatedSalesTO {
    private LocalDate date;
    private int sold;
    private long sales;
    private double increase;
}
