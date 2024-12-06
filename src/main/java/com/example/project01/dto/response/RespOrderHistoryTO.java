package com.example.project01.dto.response;

import com.example.project01.dto.PurchaseProductDetailTO;
import com.example.project01.dto.PurchaseTO;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class RespOrderHistoryTO {
    private boolean success;
    private String message;
    private List<PurchaseTO> purchase;
    private List<List<PurchaseProductDetailTO>> lists;
}
