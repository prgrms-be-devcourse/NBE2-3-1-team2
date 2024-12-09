package com.example.project01.dao;

import com.example.project01.dto.ProductOrderDTO;
import com.example.project01.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.Map;

@Repository
public class ProductOrderDAO {
    @Autowired
    private ProductOrderMapper productOrderMapper;

    public ArrayList<ProductOrderDTO> getProductOrderList(String cid) {return productOrderMapper.selectProductOrderList(cid);}
    public ArrayList<ProductOrderDTO> getListAfterInputDate(Map date) {return productOrderMapper.selectProductOrderListAfterInputDate(date);}
}
