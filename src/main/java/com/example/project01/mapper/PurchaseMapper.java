package com.example.project01.mapper;

import com.example.project01.dto.PurchaseTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PurchaseMapper {
    int purchase_info(PurchaseTO purchaseTO);
}
