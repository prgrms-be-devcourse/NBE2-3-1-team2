package com.example.project01.controller.api;

import com.example.project01.dao.CustomerDAO;
import com.example.project01.dto.CustomerTO;
import com.example.project01.dto.response.RespMessageTO;
import com.example.project01.dto.response.RespObjectTO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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
    public ResponseEntity<RespMessageTO> login(@RequestBody CustomerTO customer, HttpSession session) {
        RespMessageTO resp = new RespMessageTO();
        if (customerDAO.loginAuth(customer)) {
            session.setAttribute("s_email", customer.getEmail());
            session.setAttribute("success", true);

            resp.setSuccess(true);
            return ResponseEntity.ok(resp);
        } else {
            resp.setSuccess(false);
            resp.setMessage("아이디 또는 비밀번호가 틀렸습니다.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(resp);
        }
    }

    @GetMapping("customer/login/status")
    public ResponseEntity<RespMessageTO> loginStatus(HttpSession session) {
        RespMessageTO resp = new RespMessageTO();
        String email = (String) session.getAttribute("s_email");

        if (email != null) {
            resp.setSuccess(true);
            return ResponseEntity.ok(resp);
        } else {
            resp.setSuccess(false);
            resp.setMessage("세션 정보가 만료되었습니다. 로그인을 다시 하시기 바랍니다.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(resp);
        }
    }

    @GetMapping("customer/logout")
    public ResponseEntity<RespMessageTO> logout(HttpSession session) {
        RespMessageTO resp = new RespMessageTO();
        session.invalidate();

        resp.setSuccess(true);
        return ResponseEntity.ok(resp);
    }

    @GetMapping("customer/cart/info")
    public ResponseEntity<RespObjectTO<CustomerTO>> getCustomer(HttpSession session) {
        RespObjectTO<CustomerTO> resp = new RespObjectTO<>();
        String email = (String) session.getAttribute("s_email");
        if (email != null) {
            CustomerTO customer = customerDAO.selectCustomerByEmail(email);
            resp.setSuccess(true);
            resp.setData(customer);
            return ResponseEntity.ok(resp);
        } else {
            resp.setSuccess(false);
            resp.setMessage("세션 정보가 만료되었습니다. 로그인을 다시 하시기 바랍니다.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(resp);
        }
    }

    @PostMapping("customer/join")
    public ResponseEntity<RespMessageTO> joinCustomer(@RequestBody CustomerTO customer) {
        RespMessageTO resp = new RespMessageTO();
        boolean check;

        try {
            check = customerDAO.addCustomer(customer);
        } catch (Exception ignored) {
            check = false;
        }
        if (check) {
            resp.setSuccess(true);
            return ResponseEntity.ok(resp);
        } else {
            resp.setSuccess(false);
            resp.setMessage("이메일이 중복되었습니다.");
            return ResponseEntity.status(HttpStatus.CONFLICT).body(resp);
        }
    }
    @PostMapping("customer/join/email")
    public ResponseEntity<RespMessageTO> emailDuplicate(@RequestBody Map<String, String> request) {
        RespMessageTO resp = new RespMessageTO();
        boolean duplicate = customerDAO.CheckCustomerByEmail(request.get("email"));

        if (duplicate) {
            resp.setSuccess(false);
            resp.setMessage("이메일이 중복되었습니다");
            return ResponseEntity.status(HttpStatus.CONFLICT).body(resp);
        } else {
            resp.setSuccess(true);
            return ResponseEntity.ok(resp);
        }
    }
}