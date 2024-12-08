package com.example.project01.dto.response;

import com.example.project01.dto.CalculatedSalesTO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@ToString
public class RespDashBoardTO {
    private boolean success;
    private String message;
    private int totalCustomer;
    private long todaySales;
    private int totalProduct;
    private List<CalculatedSalesTO> purchase;
}
