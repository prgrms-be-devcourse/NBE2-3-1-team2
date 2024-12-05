package com.example.project01.controller;

import com.example.project01.dao.CustomerDAO;
import com.example.project01.dao.ProductDAO;
import com.example.project01.dto.CustomerTO;
import com.example.project01.dto.ProductTO;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import java.util.ArrayList;
import java.util.List;
import java.util.Enumeration;

@RestController
public class CoffeeApiController {

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private CustomerDAO customerDAO;

    @GetMapping( "/emp/json" )
    public ArrayList<ProductTO> product_list() {
        return productDAO.lists();
    }

    @PostMapping("/emp/cart")
    //requestBody는 객체를 받아올때 사용함 편하게 받을 수 있게
    public ArrayList<ProductTO> cart_list(@RequestBody List<ProductTO> to) {
        return productDAO.cart_lists(to);
    }

    @PostMapping("/emp/register")
    public RedirectView register(HttpServletRequest request){
        RedirectView redirectView = new RedirectView();

        String email = request.getParameter("email");
        if(customerDAO.emailCheck(email)){
            redirectView.setUrl("/join.do?error=emailExists");
            return redirectView;
        }

        CustomerTO to = new CustomerTO();
        to.setEmail(email);
        to.setPwd(request.getParameter("pw-input"));
        to.setAddr(request.getParameter("addr"));
        to.setZip(request.getParameter("zip"));

        int flag = customerDAO.register(to);

        //return "/main.do";


        redirectView.setUrl("/login.do");  // 리다이렉트할 URL
        return redirectView;
    }


}
