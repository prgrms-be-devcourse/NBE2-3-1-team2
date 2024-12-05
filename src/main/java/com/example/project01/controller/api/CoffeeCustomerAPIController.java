package com.example.project01.controller.api;

import com.example.project01.dao.CustomerDAO;
import com.example.project01.dto.CustomerTO;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("api")
public class CoffeeCustomerAPIController {

    private final CustomerDAO customerDAO;

    @Autowired
    public CoffeeCustomerAPIController(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }

    @PostMapping("customer/login")
    public ResponseEntity<Map<String, Object>> login(@RequestBody CustomerTO customer, HttpSession session) {

        Map<String, Object> respMap = new HashMap<>();

        if (customerDAO.loginAuth(customer)) {
            session.setAttribute("s_email", customer.getEmail());
            session.setAttribute("success", true);

            respMap.put("success", true);
            return ResponseEntity.ok(respMap);
        } else {
            respMap.put("success", false);
            respMap.put("message", "아이디 또는 비밀번호가 틀렸습니다.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(respMap);
        }
    }

    @GetMapping("customer/login/status")
    public ResponseEntity<Map<String, Object>> loginStatus(HttpSession session) {
        Map<String, Object> respMap = new HashMap<>();
        String email = (String) session.getAttribute("s_email");

        if (email != null) {
            respMap.put("success", true);
            return ResponseEntity.ok(respMap);
        } else {
            respMap.put("success", false);
            respMap.put("message", "세션 정보가 만료되었습니다. 로그인을 다시 하시기 바랍니다.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(respMap);
        }
    }

    @GetMapping("customer/logout")
    public ResponseEntity<Map<String, Object>> logout(HttpSession session) {
        Map<String, Object> respMap = new HashMap<>();
        session.invalidate();

        respMap.put("success", true);
        return ResponseEntity.ok(respMap);
    }

    @GetMapping("customer/cart/info")
    public ResponseEntity<Map<String, Object>> getCustomer(HttpSession session) {
        Map<String, Object> respMap = new HashMap<>();
        String email = (String) session.getAttribute("s_email");
        if (email != null) {
            CustomerTO customer = customerDAO.getCustomerByEmail(email);
            respMap.put("success", true);
            respMap.put("customer", customer);
            return ResponseEntity.ok(respMap);
        } else {
            respMap.put("success", false);
            respMap.put("message", "세션 정보가 만료되었습니다. 로그인을 다시 하시기 바랍니다.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(respMap);
        }
    }

    @PostMapping("customer/join")
    public ResponseEntity<Map<String, Object>> joinCustomer(@RequestBody CustomerTO customer) {
        Map<String, Object> respMap = new HashMap<>();
        boolean check;

        try {
            check = customerDAO.addCustomer(customer);
        } catch (Exception ignored) {
            check = false;
        }
        if (check) {
            respMap.put("success", check);
            return ResponseEntity.ok(respMap);
        } else {
            respMap.put("success", check);
            respMap.put("message", "이메일이 중복되었습니다.");
            return ResponseEntity.status(HttpStatus.CONFLICT).body(respMap);
        }
    }
    @PostMapping("customer/join/email")
    public ResponseEntity<Map<String, Object>> joinDuplicate(@RequestBody Map<String, String> request) {
        Map<String, Object> respMap = new HashMap<>();
        boolean duplicate = customerDAO.CheckCustomerByEmail(request.get("email"));

        if (duplicate) {
            respMap.put("success", false);
            respMap.put("message", "이메일이 중복되었습니다");
            return ResponseEntity.status(HttpStatus.CONFLICT).body(respMap);
        } else {
            respMap.put("success", true);
            return ResponseEntity.ok(respMap);
            
        }
    }
}