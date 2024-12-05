package com.example.project01.controller;

import com.example.project01.dao.CustomerDAO;
import com.example.project01.dao.ProductDAO;
import com.example.project01.dto.CustomerTO;
import com.example.project01.dto.ProductTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class CoffeeApiController {

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private CustomerDAO customerDAO;

    @GetMapping(value = "/api/product")
    // 데이터 조회
    // 바로 (query에서 받아온 것을 return)
    public ArrayList<ProductTO> getProducts() {
        System.out.println(productDAO.productList());
        return productDAO.productList();
    }

    // 장바구니에 있는 값만 보여야함
    @PostMapping(value = "/api/cartview")
    // RequestBody : 객체 받아옴
    public ArrayList<ProductTO> getCartView(@RequestBody List<ProductTO> productId) {
        System.out.println("PID : " + productId);

        ArrayList<ProductTO> cartItems = productDAO.cartList(productId);
        System.out.println("Cart Items: " + cartItems);

        return cartItems;
    }

    // 회원가입
    @PostMapping(value = "/api/register")
    public ResponseEntity<String> customerRegister(@RequestBody CustomerTO customerTO) {
    // public String registerCustomer(@RequestBody CustomerTO customerTO) {
        System.out.println("ZIP: " + customerTO.getZip()); // 제약사항있었음(5글자)

        // 이메일 중복 확인
        int emailExists = customerDAO.emailCheck(customerTO.getEmail());
        if (emailExists > 0) {
            System.out.println("이미 존재하는 이메일: " + customerTO.getEmail());
            return ResponseEntity.status(HttpStatus.CONFLICT).body("{\"status\":\"email_exists\"}");
        }

        // 회원 가입 처리
        int result = customerDAO.customerRegister(customerTO);
        if (result > 0) {
            System.out.println("회원가입 성공: " + customerTO.getEmail());
            // return ResponseEntity.ok("{\"status\":\"success\"}");
            return ResponseEntity.status(HttpStatus.FOUND)
                    .header("Location", "/login.do") // 리다이렉트할 URL
                    .build();
        } else {
            System.out.println("회원가입 실패");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("{\"status\":\"failure\"}");
        }
        // return "{\"result\" : \"" + result + "\"}";
    }

    // 보안과 높은 관련이 있으므로 백엔드에서 처리
    @GetMapping(value = "/api/checkSession")
    public ResponseEntity<String> checkSession(HttpSession session) {
        String email = (String) session.getAttribute("email");
        if (email != null) {
            System.out.println("session" + email);
            return ResponseEntity.ok("{\"status\":\"logged_in\"}");
        } else {
            System.out.println("session" + email);
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("{\"status\":\"not_logged_in\"}");
        }
    }

    // 로그인 처리(받아온 값과 동일하면 성공, 그렇지 않으면 실패 반환)
    @PostMapping(value = "/api/login")
    public ResponseEntity<String> login(@RequestBody CustomerTO customerTO, HttpSession session) {
        int emailExists = customerDAO.emailCheck(customerTO.getEmail());
        // 비밀번호 비교는 sql 에서 진행하고 true, false 하도록
        boolean pwdExists = customerDAO.passwordCheck(customerTO);
        // System.out.println(customerTO.getEmail());
        // System.out.println(customerTO.getPwd());
        // System.out.println(pwdExists);

        // email 존재하지 않는 경우, -1
        System.out.println(emailExists);
        if (emailExists > 0) {
            // 비밀 번호 비교
            if(pwdExists) {
                System.out.println("로그인 성공");

                /// 세션 저장
                session.setAttribute("email", customerTO.getEmail());
                System.out.println("session : " + session.getAttribute("email"));
                // return 200
                return ResponseEntity.ok("{\"status\":\"login_success\"}");
            } else {
                System.out.println("로그인 실패");
                // return 401
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("{\"status\":\"password_incorrect\"}");
            }
        } else {
            // email 존재하지 않는다는 alert
            // return 404
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("{\"status\":\"email_not_found\"}");
        }
    }

    @GetMapping(value = "/api/logout")
    public ResponseEntity<String> logout(HttpSession session) {
        session.invalidate();
        return ResponseEntity.ok("{\"status\":\"logout_success\"}");
    }
}
