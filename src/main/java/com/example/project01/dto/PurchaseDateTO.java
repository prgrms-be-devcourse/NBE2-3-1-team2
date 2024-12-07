package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Getter
@ToString
@Alias("purchase_date")
public class PurchaseDateTO {
    @Setter
    private int cid;
    @Setter
    private String email;
    private final LocalDateTime start;
    private final LocalDateTime end;

    public PurchaseDateTO(LocalDate start, LocalDate end) {
        this.start = start.atStartOfDay();
        this.end = end.atTime(LocalTime.MAX);
    }
}
