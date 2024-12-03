package com.example.project01.controller;

import com.example.project01.dao.CustomerDAO;
import com.example.project01.dao.ProductDAO;
import com.example.project01.dao.PurchaseDAO;
import com.example.project01.dao.PurchaseDetailDAO;
import com.example.project01.dto.ProductDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;

@RestController
@RequestMapping("/api")
public class CoffeeApiController {
    @Autowired
    private CustomerDAO customerDAO;
    @Autowired
    private ProductDAO productDAO;
    @Autowired
    private PurchaseDAO purchaseDAO;
    @Autowired
    private PurchaseDetailDAO purchaseDetailDAO;

    @GetMapping("/product")
    public ArrayList<ProductDTO> productList() {
        return productDAO.getProductList();
    }
}
