package com.example.project01.controller.api;

import com.example.project01.dao.AdminDAO;
import com.example.project01.dao.CustomerDAO;
import com.example.project01.dto.CustomerTO;
import com.example.project01.dto.response.RespDashBoardTO;
import com.example.project01.dto.response.RespMessageTO;
import com.example.project01.dto.response.RespObjectTO;
import com.example.project01.service.DashBoardService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("api")
public class CoffeeAdminAPIController {


    private final AdminDAO adminDAO;
    private final DashBoardService dashBoardService;

    @Autowired
    public CoffeeAdminAPIController(AdminDAO adminDAO, DashBoardService dashBoardService) {
        this.adminDAO = adminDAO;
        this.dashBoardService = dashBoardService;
    }

    @GetMapping("admin/logout")
    public ResponseEntity<RespMessageTO> logout(HttpSession session) {
        RespMessageTO resp = new RespMessageTO();
        session.invalidate();

        resp.setSuccess(true);
        return ResponseEntity.ok(resp);
    }

    @GetMapping("admin/login/status")
    public ResponseEntity<RespMessageTO> loginStatus(HttpSession session) {
        RespMessageTO resp = new RespMessageTO();
        String email = (String) session.getAttribute("a_email");

        if (email != null) {
            resp.setSuccess(true);
            return ResponseEntity.ok(resp);
        } else {
            resp.setSuccess(false);
            resp.setMessage("세션 정보가 만료되었습니다. 로그인을 다시 하시기 바랍니다.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(resp);
        }
    }

    @PostMapping("admin/login")
    public ResponseEntity<RespMessageTO> login(@RequestBody CustomerTO customer, HttpSession session) {
        RespMessageTO resp = new RespMessageTO();
        if (adminDAO.loginAuth(customer)) {
            session.setAttribute("a_email", customer.getEmail());
            session.setAttribute("success", true);

            resp.setSuccess(true);
            return ResponseEntity.ok(resp);
        } else {
            resp.setSuccess(false);
            resp.setMessage("아이디 또는 비밀번호가 틀렸습니다.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(resp);
        }
    }

    @GetMapping("admin/dashboard")
    public ResponseEntity<RespDashBoardTO> dashboard() {
        RespDashBoardTO resp = dashBoardService.getDashboard();
        if (resp.isSuccess()) {
            return ResponseEntity.ok(resp);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(resp);
        }
    }

}