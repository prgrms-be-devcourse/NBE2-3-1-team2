package com.example.project01.dao;

import com.example.project01.dto.ProductDTO;
import com.example.project01.mapper.CustomerMapper;
import com.example.project01.mapper.ProductMapper;
import com.example.project01.mapper.PurchaseDetailMapper;
import com.example.project01.mapper.PurchaseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public class ProductDAO {
    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private CustomerMapper customerMapper;
    @Autowired
    private PurchaseMapper purchaseMapper;
    @Autowired
    private PurchaseDetailMapper purchaseDetailMapper;
    public ArrayList<ProductDTO> getProductList() {return productMapper.selectAllProduct();}
}
