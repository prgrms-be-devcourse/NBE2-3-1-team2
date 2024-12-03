package com.example.project01.controller;

import com.example.project01.dao.CoffeeDAO;
import com.example.project01.dto.ProductTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;

@Controller
//@RequestMapping( "/web")
public class CoffeeWebController {

    @Autowired
    CoffeeDAO coffeeDAO;

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
