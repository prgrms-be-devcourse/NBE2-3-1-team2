package com.example.project01.dao;

import com.example.project01.dto.ProductTO;
import com.example.project01.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.lang.reflect.Array;
import java.util.ArrayList;

@Repository
public class ProductDAO {
    @Autowired
    private ProductMapper productMapper;

    public ArrayList<ProductTO> productList(){
        return productMapper.product_list();
    }
}
