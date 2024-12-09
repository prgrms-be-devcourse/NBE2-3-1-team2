package com.example.project01.mapper;

import com.example.project01.dto.PurchaseDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PurchaseMapper {
    PurchaseDTO lastPurchase();
    int insertPurchase(PurchaseDTO dto);
    int updatePurchase(int pid);
    void updateStatus();
}
