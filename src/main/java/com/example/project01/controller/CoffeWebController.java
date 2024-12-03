package com.example.project01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CoffeWebController {

    @RequestMapping("main.do")
    public String shop() {
        return "product_list";
    }

    @RequestMapping("login.do")
    public String login() {
        return "login";
    }

    @RequestMapping("cart.do")
    public String cart() {
        return "shopping_cart";
    }

    @RequestMapping("join.do")
    public String join() {
        return "register";
    }

    @RequestMapping("order.do")
    public String order() {
        return "purchase_history";
    }
}
