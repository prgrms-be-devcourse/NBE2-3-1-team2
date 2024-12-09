package com.example.project01.mapper;

import com.example.project01.dto.PurchaseDetailDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;

@Mapper
public interface PurchaseDetailMapper {
    int insertPurchaseDetail(PurchaseDetailDTO dto);
}
