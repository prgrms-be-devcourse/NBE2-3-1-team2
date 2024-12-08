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

    @RequestMapping("mypage.do")
    public String mypage(HttpSession session) {
        if (session.getAttribute("s_email") != null) {
            return "user_page";
        }
        return "redirect:/main.do";
    }

    @RequestMapping("management.login")
    public String management(HttpSession session) {
        if (session.getAttribute("a_email") != null) {
            return "redirect:/management.view";
        }
        return "admin_auth";
    }

    @RequestMapping("management.view")
    public String managementView(HttpSession session) {
        if (session.getAttribute("a_email") != null) {
            return "admin_dashboard";
        }
        return "redirect:/management.login";
    }
    @RequestMapping("management.customer")
    public String managementCustomer(HttpSession session) {
        if (session.getAttribute("a_email") != null) {
            return "admin_customer";
        }
        return "redirect:/management.login";
    }
    @RequestMapping("management.cost")
    public String managementCost(HttpSession session) {
        if (session.getAttribute("a_email") != null) {
            return "admin_cost";
        }
        return "redirect:/management.login";
    }
    @RequestMapping("management.product")
    public String managementProduct(HttpSession session) {
        if (session.getAttribute("a_email") != null) {
            return "admin_product";
        }
        return "redirect:/management.login";
    }
}
