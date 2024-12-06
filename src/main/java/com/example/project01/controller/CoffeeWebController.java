package com.example.project01.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CoffeeWebController {
    @RequestMapping("main.do")
    public String shop() {
        return "product_list";
    }

    @RequestMapping("order.do")
    public String order(HttpSession session) {
        if (session.getAttribute("s_email") != null) { // 로그인 정보 확인
            return "purchase_history";
        }
        return "redirect:/login.do";
    }

    @RequestMapping("cart.view")
    public String cart(HttpSession session) {
        return "shopping_cart";
    }

    @RequestMapping("login.do")
    public String login(HttpSession session) {
        if (session.getAttribute("s_email") != null) { // 로그인 정보 확인
            return "redirect:/main.do";
        }
        return "login";
    }

    @RequestMapping("join.do")
    public String join(HttpSession session) {
        if (session.getAttribute("s_email") != null) { // 로그인 정보 확인
            return "redirect:/main.do";
        }
        return "register";
    }

}
