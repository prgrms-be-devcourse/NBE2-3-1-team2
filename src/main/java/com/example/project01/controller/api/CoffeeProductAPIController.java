package com.example.project01.controller.api;

import com.example.project01.dao.ProductDAO;
import com.example.project01.dto.ProductTO;
import com.example.project01.dto.UserCartTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api")
public class CoffeeProductAPIController {

    private final ProductDAO productDAO;

    @Autowired
    public CoffeeProductAPIController(ProductDAO productDAO) {
        this.productDAO = productDAO;
    }

    @GetMapping("product/list")
    public List<ProductTO> getAllProducts() {
        return productDAO.selectAll();
    }

    @PostMapping("product/cart/list")
    public List<UserCartTO> getCartProducts(@RequestBody List<UserCartTO> cart) {
        return productDAO.selectCartList(cart);
    }
}