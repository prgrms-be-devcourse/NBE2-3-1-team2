package com.example.project01.controller;

import com.example.project01.dao.ProductDAO;
import com.example.project01.dto.ProductTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;

@Controller
public class CoffeeWebController {

    @Autowired
    private ProductDAO productDAO;

    @RequestMapping("main.do")
    public String main(Model model) {

        ArrayList<ProductTO> lists = productDAO.productList();
        model.addAttribute("lists", lists);
        return "product_list";
    }

    @RequestMapping("order.do")
    public String order() {
        return "purchase_history";
    }

    @RequestMapping("cartview.do")
    public String cartview() {
        return "shopping_cart";
    }

    @RequestMapping("login.do")
    public String login() {
        return "login";
    }

    @RequestMapping("register.do")
    public String register() {
        return "register";
    }
}
