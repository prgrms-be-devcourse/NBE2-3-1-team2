package com.example.project01.mapper;

import com.example.project01.dto.PurchaseDetailTO;
import com.example.project01.dto.PurchaseTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PurchaseMapper {

    int purchase(PurchaseTO to);
    int detail(PurchaseDetailTO detail);
    void updatePendingPurchase();
}
