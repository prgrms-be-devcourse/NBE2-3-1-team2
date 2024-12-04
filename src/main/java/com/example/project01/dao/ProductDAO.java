package com.example.project01.dao;

import com.example.project01.dto.ProductTO;
import com.example.project01.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;

@Repository
public class ProductDAO {
    @Autowired
    private ProductMapper productMapper;

    public ArrayList<ProductTO> productList(){
        return productMapper.product_list();
    }

    public ArrayList<ProductTO> cartList(List<ProductTO> pids) {
        // return list
        ArrayList<ProductTO> to = new ArrayList<>();
        // (pids 받아와서) mapper 인자로 넣음
        pids.forEach(p -> to.add(productMapper.cart_list(p)));

        return to;
    }
}
