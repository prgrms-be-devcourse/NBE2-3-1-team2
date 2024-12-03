package com.example.project01.controller;

import com.example.project01.dao.CustomerDAO;
import com.example.project01.dao.ProductDAO;
import com.example.project01.dto.CustomerDTO;
import com.example.project01.dto.ProductTO;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
public class CoffeeApiController {

    @Autowired
    private ProductDAO productDAO;

    @GetMapping( "/emp/json" )
    public ArrayList<ProductTO> product_list() {
        return productDAO.lists();
    }

    @PostMapping("/emp/cart")
    //requestBody는 객체를 받아올때 사용함 편하게 받을 수 있게
    public ArrayList<ProductTO> cart_list(@RequestBody List<ProductTO> to) {
        return productDAO.cart_lists(to);
    }

    @RequestMapping("/login_ok")
    public String login_ok(
            String id,
            String password,
            Model model,
            HttpServletResponse response
    ){
        //id, password 일단 정해서 비교할거임
        String saveId = "tester@naver.com";
        String savePassword = "1234";

        int flag = 2;
        if(saveId.equals(id) && savePassword.equals(password)) {
            //정상 로그인
            flag = 0;

            Cookie cookie = new Cookie("cid", id);
            Cookie cookie2 = new Cookie("cgrade", "A");

            response.addCookie(cookie);
            response.addCookie(cookie2);

            return "redirect:/main.do";
        } else {
            flag = 1;
            return "redirect:/login.do";
        }


    }


}
