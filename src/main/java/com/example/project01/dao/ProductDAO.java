package com.example.project01.dao;

import com.example.project01.dto.ProductTO;
import com.example.project01.mapper.CustomerMapper;
import com.example.project01.mapper.ProductMapper;
import com.example.project01.mapper.PurchaseDetailMapper;
import com.example.project01.mapper.PurchaseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class ProductDAO {

    @Autowired
    ProductMapper productMapper;

    public ArrayList<ProductTO> productAll(){
        return productMapper.productList();
    }
    public ArrayList<ProductTO> findProduct(List<Integer> pidList) {

        ArrayList<ProductTO> findList = new ArrayList<>();
        for( int pid : pidList ) {
            ProductTO to = productMapper.findProduct(pid);
            findList.add(to);
        }

        return findList;
    }
}
