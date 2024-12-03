package com.example.project01.dao;

import com.example.project01.dto.ProductTO;
import com.example.project01.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class ProductDAO {

    @Autowired
    private ProductMapper productMapper;

    public ArrayList<ProductTO> lists() {
        return productMapper.lists();
    }
    public ArrayList<ProductTO> cart_lists(List<ProductTO> to) {
        ArrayList<ProductTO> list = new ArrayList<>();

        to.forEach(item -> list.add(productMapper.cart_lists(item.getPid())));

        return list;
    }
}
