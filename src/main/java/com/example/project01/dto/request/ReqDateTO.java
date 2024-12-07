package com.example.project01.dto.request;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Getter
@ToString
public class ReqDateTO {
    @Setter
    private String email;
    @Setter
    private LocalDate start;
    @Setter
    private LocalDate end;
    private LocalDateTime startDate;
    private LocalDateTime endDate;

    public void setStartDate(LocalDate start) {
        this.startDate = start.atStartOfDay();
    }

    public void setEndDate(LocalDate end) {
        this.endDate = end.atTime(LocalTime.MAX);
    }
}
