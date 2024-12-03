package com.example.project01.controller;

import com.example.project01.dao.ProductDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
//@RequestMapping( "/web")
public class CoffeeWebController {

    @Autowired
    ProductDAO productDAO;

    // 회원가입
    @RequestMapping("/join.do")
    public String join(){
        return "register";
    }

    // 회원가입 처리
    @RequestMapping("/join_ok.do")
    public String joinOK(){

        return "register_ok";
    }

    // 로그인
    @RequestMapping("/login.do")
    public String login(){
        return "login";
    }

    // 상품 리스트 ( 메인 페이지 )
    @RequestMapping("/main.do")
    public String main(Model model){

//        ArrayList<ProductTO> lists = coffeeDAO.productAll();
//        model.addAttribute("lists", lists);

        return "product_list";
    }

    // 주문 내역
    @RequestMapping("/order.do")
    public String purchase(){
        return "purchase_history";
    }

    // 장바구니
    @RequestMapping("/cartview.do")
    public String cart(){
        return "shopping_cart";
    }

}
