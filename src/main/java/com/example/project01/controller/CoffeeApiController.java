package com.example.project01.controller;

import com.example.project01.dao.CoffeeDAO;
import com.example.project01.dto.ProductTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;

@RestController
@RequestMapping("/api")
public class CoffeeApiController {

    @Autowired
    private CoffeeDAO coffeeDAO;

    @GetMapping("/product")
    public ArrayList<ProductTO> productList() {
        return coffeeDAO.productAll();
    }

}
