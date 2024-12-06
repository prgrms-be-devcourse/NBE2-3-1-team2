package com.example.project01.controller.api;

import com.example.project01.dto.request.ReqOrderTO;
import com.example.project01.dto.response.RespMessageTO;
import com.example.project01.dto.response.RespOrderHistoryTO;
import com.example.project01.service.OrderService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api")
public class CoffeeOrderAPIController {

    private final OrderService orderService;

    @Autowired
    public CoffeeOrderAPIController(OrderService orderService) {
        this.orderService = orderService;
    }

    @PostMapping("order/purchase")
    public ResponseEntity<RespMessageTO> login(@RequestBody ReqOrderTO order, HttpSession session) {
        RespMessageTO resp = new RespMessageTO();
        if (order.getCustomer().getEmail().equals(session.getAttribute("s_email"))) {
            resp = orderService.addOrderList(order);

            return ResponseEntity.ok(resp);
        } else {
            resp.setSuccess(false);
            resp.setMessage("이메일 정보가 로그인 정보와 일치하지 않습니다.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(resp);
        }
    }

    @GetMapping("order/history")
    public ResponseEntity<RespOrderHistoryTO> getOrderHistory(HttpSession session) {
        RespOrderHistoryTO resp = orderService.getOrderHistory((String) session.getAttribute("s_email"));
        if (resp.isSuccess()) {
            return ResponseEntity.ok(resp);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(resp);
        }
    }

    @PutMapping("order/customer/refunds")
    public ResponseEntity<RespMessageTO> refundOrder(@RequestBody ReqOrderTO order, HttpSession session) {
        RespMessageTO resp = new RespMessageTO();


        return ResponseEntity.ok(resp);
    }
}