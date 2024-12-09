package com.example.project01.controller;

import com.example.project01.dao.CustomerDAO;
import com.example.project01.dao.ProductOrderDAO;
import com.example.project01.dto.CustomerDTO;
import com.example.project01.dto.ProductOrderDTO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;

@Controller
public class CoffeeWebController {
    @Autowired
    private CustomerDAO CustomerDAO;

    @Autowired
    private ProductOrderDAO productOrderDAO;

    @RequestMapping("/main.do")
    public String productList(
            @CookieValue(name = "cart", defaultValue="[]") String cartData,
            HttpSession session,
            Model model) {
        int cookieCount = (int) URLDecoder.decode(cartData, StandardCharsets.UTF_8).chars().filter(ch -> ch == '}').count();
        model.addAttribute("cookieCount", cookieCount);
        model.addAttribute("cid", session.getAttribute("cid"));
        model.addAttribute("message", model.getAttribute("message"));
        return "product_list";
    }

    @RequestMapping("/cartView.do")
    public String shoppingCart(
            @CookieValue(name = "cart", defaultValue="[]") String cartData,
            HttpSession session,
            Model model) {
        int cookieCount = (int) URLDecoder.decode(cartData, StandardCharsets.UTF_8).chars().filter(ch -> ch == '}').count();
        String cid = (String) session.getAttribute("cid");
        model.addAttribute("cookieCount", cookieCount);
        model.addAttribute("cid", cid);
        if ( cid != null ) {
            CustomerDTO customerDTO = CustomerDAO.selectCustomerById(cid);
            model.addAttribute("customer", customerDTO);
        }
        return "shopping_cart";
    }

    @RequestMapping("/login.do")
    public String login(
            @CookieValue(name = "cart", defaultValue="[]") String cartData,
            @CookieValue(name = "email", defaultValue="") String emailData,
            @CookieValue(name = "saveEmailOption", defaultValue="false") String saveEmailOption,
            RedirectAttributes redirectAttributes,
            HttpSession session,
            Model model) {
        int cookieCount = (int) URLDecoder.decode(cartData, StandardCharsets.UTF_8).chars().filter(ch -> ch == '}').count();
        String email = URLDecoder.decode(emailData, StandardCharsets.UTF_8);
        model.addAttribute("cookieCount", cookieCount);
        model.addAttribute("email", email);
        model.addAttribute("option", saveEmailOption);
        model.addAttribute("cid", session.getAttribute("cid"));
        model.addAttribute("message", model.getAttribute("message"));
        if (session.getAttribute("cid") != null) {
            redirectAttributes.addFlashAttribute("message", "잘못된 접근입니다.");
            return "redirect:/main.do";
        }
        return "login";
    }


    @RequestMapping("/order.do")
    public String purchaseHistory(
            @CookieValue(name = "cart", defaultValue="[]") String cartData,
            RedirectAttributes redirectAttributes,
            HttpSession session,
            Model model) {
        int cookieCount = (int) URLDecoder.decode(cartData, StandardCharsets.UTF_8).chars().filter(ch -> ch == '}').count();
        if (session.getAttribute("cid") == null) {
            redirectAttributes.addFlashAttribute("message", "로그인이 필요한 서비스입니다.");
            return "redirect:/login.do";
        }
        // 주문 내역 페이지로 데이터 전송 및 이동
        model.addAttribute("cookieCount", cookieCount);
        model.addAttribute("cid", session.getAttribute("cid"));
        return "purchase_history";
    }

    @RequestMapping("/join.do")
    public String register(
            @CookieValue(name = "cart", defaultValue="[]") String cartData,
            HttpSession session,
            RedirectAttributes redirectAttributes,
            Model model) {
        int cookieCount = (int) URLDecoder.decode(cartData, StandardCharsets.UTF_8).chars().filter(ch -> ch == '}').count();
        if (session.getAttribute("cid") != null) {
            redirectAttributes.addFlashAttribute("message", "잘못된 접근입니다.");
            return "redirect:/main.do";
        }
        model.addAttribute("cookieCount", cookieCount);
        model.addAttribute("cid", session.getAttribute("cid"));
        return "register";
    }

    @RequestMapping("/deactivate.do")
    public String deactivate(
            @CookieValue(name = "cart", defaultValue="[]") String cartData,
            HttpSession session,
            RedirectAttributes redirectAttributes,
            Model model) {
        int cookieCount = (int) URLDecoder.decode(cartData, StandardCharsets.UTF_8).chars().filter(ch -> ch == '}').count();
        if (session.getAttribute("cid") == null) {
            redirectAttributes.addFlashAttribute("message", "로그인이 필요한 서비스입니다.");
            return "redirect:/login.do";
        }
        model.addAttribute("cookieCount", cookieCount);
        model.addAttribute("cid", session.getAttribute("cid"));
        return "deactivate";
    }

    @RequestMapping("/test.do")
    public String test(){
        return "test";
    }
}
