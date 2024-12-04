package com.example.project01.controller;

import com.example.project01.dao.ProductDAO;
import com.example.project01.dto.CustomerTO;
import com.example.project01.dto.ProductTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
public class CoffeeApiController {

    @Autowired
    private ProductDAO productDAO;

    @GetMapping(value = "/api/product")
    // 데이터 조회
    // 바로 (query에서 받아온 것을 return)
    public ArrayList<ProductTO> getProducts() {
        System.out.println(productDAO.productList());
        return productDAO.productList();
    }

    // 장바구니에 있는 값만 보여야함
    @PostMapping(value = "/api/cartview")
    // RequestBody : 객체 받아옴
    public ArrayList<ProductTO> getCartView(@RequestBody List<ProductTO> productId) {
        System.out.println("PID : " + productId);

        ArrayList<ProductTO> cartItems = productDAO.cartList(productId);
        System.out.println("Cart Items: " + cartItems);

        return cartItems;
    }
}
