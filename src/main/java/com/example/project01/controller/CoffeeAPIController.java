package com.example.project01.controller;

import com.example.project01.dao.ProductDAO;
import com.example.project01.dto.ProductTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api")
public class CoffeeAPIController {

    private ProductDAO productDAO;

    @Autowired
    public CoffeeAPIController(ProductDAO productDAO) {
        this.productDAO = productDAO;
    }

    @GetMapping("product/list")
    public List<ProductTO> getAllProducts() {
        return productDAO.selectAll();
    }

    @PostMapping("product/cart/list")
    public List<ProductTO> getCartProducts(@RequestBody List<ProductTO> products) {
        return productDAO.selectCartList(products);
    }
}