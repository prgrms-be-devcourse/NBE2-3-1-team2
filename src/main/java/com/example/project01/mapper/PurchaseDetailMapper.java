package com.example.project01.mapper;

import com.example.project01.dto.PurchaseDetailTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PurchaseDetailMapper {
    int purchaseDetailInfo(PurchaseDetailTO purchaseDetailTO);
}