package com.example.project01.dao;

import com.example.project01.dto.ProductTO;
import com.example.project01.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class ProductDAO {
    ProductMapper productMapper;

    @Autowired
    public ProductDAO(ProductMapper productMapper) {
        this.productMapper = productMapper;
    }

    public List<ProductTO> selectAll() {
        return productMapper.selectAll();
    }

    public List<ProductTO> selectCartList(List<ProductTO> productList) {
        List<ProductTO> cartList = new ArrayList<>();
        productList.forEach(product -> cartList.add(productMapper.selectById(product.getPid())));
        return cartList;
    }
}
