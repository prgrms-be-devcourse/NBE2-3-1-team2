package com.example.project01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CoffeeWebController {

    @RequestMapping("main.do")
    public String main() {
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
