package com.example.project01.mapper;

import com.example.project01.dto.ProductOrderDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.Map;

@Mapper
public interface ProductOrderMapper {
    ArrayList<ProductOrderDTO> selectProductOrderList(String cid);
    ArrayList<ProductOrderDTO> selectProductOrderListAfterInputDate(Map date);
}
