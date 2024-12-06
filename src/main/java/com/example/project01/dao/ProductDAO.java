package com.example.project01.dao;

import com.example.project01.dto.ProductTO;
import com.example.project01.dto.UserCartTO;
import com.example.project01.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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

    public List<UserCartTO> selectCartList(List<UserCartTO> cartProducts) {
        List<Integer> pids = cartProducts.stream()
                .map(UserCartTO::getPid)
                .toList();

        List<UserCartTO> getDataCart = productMapper.selectByIds(pids);

        Map<Integer, UserCartTO> productMap = getDataCart.stream()
                .collect(Collectors.toMap(UserCartTO::getPid, product -> product));

        return cartProducts.stream()
                .map(item -> {
                    UserCartTO product = productMap.get(item.getPid());
                    if (product != null) {
                        product.setQty(item.getQty()); // 기존 qty 유지
                        return product;
                    }
                    return item; // 매핑 실패 시 원래 객체 유지 (예외 처리 가능)
                })
                .collect(Collectors.toList());
    }

//    public List<UserCartTO> getPrice(List<UserCartTO> cartProducts) {
//        cartProducts.forEach(item -> item.setPrice(productMapper.selectPriceById(item.getPid())));
//        return cartProducts;
//    }
}
