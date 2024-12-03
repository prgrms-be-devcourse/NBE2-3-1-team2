package com.example.project01.dao;

import com.example.project01.dto.ProductTO;
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
    CustomerMapper customerMapper;
    @Autowired
    ProductMapper productMapper;
    @Autowired
    PurchaseMapper purchaseMapper;
    @Autowired
    PurchaseDetailMapper purchaseDetailMapper;

    public ArrayList<ProductTO> productAll(){
        return productMapper.productList();
    }
}
