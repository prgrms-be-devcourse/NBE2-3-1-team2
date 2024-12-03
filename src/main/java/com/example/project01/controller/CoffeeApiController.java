package com.example.project01.controller;

import com.example.project01.dao.ProductDAO;
import com.example.project01.dto.CustomerTO;
import com.example.project01.dto.ProductTO;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;

@RestController
public class CoffeeApiController {

    ProductDAO productDAO = new ProductDAO();

    @GetMapping(value = "/api/product")
    // 데이터 조회
    // 바로 (query에서 받아온 것을 return)
    public ArrayList<ProductTO> getProducts() {
        System.out.println(productDAO.productList());
        return productDAO.productList();
    }
}
