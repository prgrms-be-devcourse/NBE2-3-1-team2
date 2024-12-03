package com.example.project01.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.MalformedURLException;

@Controller
public class CoffeeWebController {
    @Autowired
    private CoffeeApiController coffeeApiController;

    @RequestMapping("/main.do")
    public String productList(Model model) {
        model.addAttribute("list", coffeeApiController.productList());
        return "product_list";
    }

    @RequestMapping("/login.do")
    public String login() {
        return "login";
    }

    @RequestMapping("/order.do")
    public String purchaseHistory() {
        return "purchase_history";
    }

    @RequestMapping("/join.do")
    public String register() {
        return "register";
    }

    @RequestMapping("/cartView.do")
    public String shoppingCart() {
        return "shopping_cart";
    }
}
