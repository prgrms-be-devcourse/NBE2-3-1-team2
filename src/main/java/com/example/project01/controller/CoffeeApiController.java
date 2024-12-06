package com.example.project01.controller;

import com.example.project01.dao.CustomerDAO;
import com.example.project01.dao.ProductDAO;
import com.example.project01.dao.PurchaseDAO;
import com.example.project01.dto.*;
import com.example.project01.enums.OrderStatus;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.*;


@RestController
public class CoffeeApiController {

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private CustomerDAO customerDAO;

    @Autowired
    private PurchaseDAO purchaseDAO;

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

    @PostMapping("/emp/login")
    public RedirectView login(HttpServletRequest request){
        RedirectView redirectView = new RedirectView();

        String email = request.getParameter("email");
        String password = request.getParameter("password");


        CustomerTO to = new CustomerTO();
        to.setEmail(email);
        to.setPwd(password);


        if(customerDAO.login(to)){
            redirectView.setUrl("/main.do");
            HttpSession session = request.getSession();
            session.setAttribute("login_email", email);

        } else {
            redirectView.setUrl("/login.do?error=loginfailed");
        }

        return redirectView;
    }

    @RequestMapping("/emp/logout")
    public RedirectView logout(HttpServletRequest request){
        RedirectView redirectView = new RedirectView();

        HttpSession session = request.getSession();
        session.invalidate();


        redirectView.setUrl("/main.do");

        return redirectView;
    }

    @GetMapping("/emp/loginStatus")
    public Map<String, Boolean> getLoginStatus(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("login_email") != null);
        Map<String, Boolean> response = new HashMap<>();
        response.put("isLoggedIn", isLoggedIn);
        return response;
    }

    @PostMapping("/emp/purchase")
    public String purchase(@RequestBody PurchaseTO request) {

        // 현재 시간을 포함한 주문 시간 (시간까지 필요)
        LocalDateTime ot = LocalDateTime.now();  // 주문 시간 (시간 포함)
        // sst는 날짜만 필요하므로, 시간은 00:00으로 설정
        LocalDateTime sst = ot.toLocalDate().atTime(14, 0);  // 날짜만 필요하고, 시간은 00:00으로 설정

        // 주문 시간과 상태 시간을 출력
        System.out.println("주문 시간(ot): " + ot);
        System.out.println("상태 시간(sst): " + sst);


        OrderStatus st = OrderStatus.PENDING;
        String zip = request.getZip();
        String addr = request.getAddr();
        String email = request.getEmail();
        Integer cid = customerDAO.findCid(email);
        if (cid == null) {
            System.out.println("해당 이메일로 등록된 고객이 없습니다.");
            return "고객 정보가 없습니다.";
        } else {
            System.out.println("고객 ID: " + cid);
        }

        PurchaseTO purchase = new PurchaseTO();
        purchase.setCid(cid);
        purchase.setOt(Timestamp.valueOf(ot));  // LocalDateTime -> Timestamp로 변환
        purchase.setSst(Timestamp.valueOf(sst));  // LocalDateTime -> Timestamp로 변환
        purchase.setZip(zip);
        purchase.setAddr(addr);
        purchase.setSt(String.valueOf(st));

        purchaseDAO.purchase(purchase);

        for(CartItem items : request.getCart()) {
            System.out.println("상품명: " + items.getName() + ", 수량: " + items.getCount() + ", 가격: " + items.getPrice());
            // 여기에 장바구니 데이터를 DB에 저장하는 로직 추가
            PurchaseDetailTO detail = new PurchaseDetailTO();
            detail.setPid(purchase.getPid());  // purchase의 pid를 사용
            detail.setCid(cid);
            detail.setPrd_id(items.getPid());
            detail.setQty(items.getCount());
            detail.setPrice(items.getPrice());

            purchaseDAO.detail(detail);
        }


        return "정보 확인";
    }



}
