package com.example.project01.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
@ToString
@NoArgsConstructor
@Alias(value = "pto")
public class PurchaseDTO {
    private int pid;
    private int cid;
    private LocalDateTime ot;
    private LocalDate sst;
    private String zip;
    private String addr;
    private String st;

    public PurchaseDTO(int cid, LocalDateTime ot, LocalDate sst, String zip, String addr, String st) {
        this.cid = cid;
        this.ot = ot;
        this.sst = sst;
        this.zip = zip;
        this.addr = addr;
        this.st = st;
    }
}
