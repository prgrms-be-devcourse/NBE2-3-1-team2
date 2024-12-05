package com.example.project01.controller;

import com.example.project01.dao.CustomerDAO;
import com.example.project01.dao.ProductDAO;
import com.example.project01.dto.CustomerTO;
import com.example.project01.dto.ProductTO;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/api")
public class CoffeeApiController {

    @Autowired
    private ProductDAO productDAO;
    @Autowired
    private CustomerDAO customerDAO;

    @GetMapping("/productList")
    public ArrayList<ProductTO> productList() {
        return productDAO.productAll();
    }

    @GetMapping("/cartList")
    public ArrayList<ProductTO> cartList(@RequestParam String pidArray) {

        ArrayList<ProductTO> cartList = new ArrayList<>();

        // Json 문자열을 list로 변환하는 로직
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            // JSON 문자열을 List로 변환
            List<Integer> pidList = objectMapper.readValue(pidArray, List.class);
            cartList = productDAO.findProduct(pidList);

        } catch (Exception e) {
            System.out.println("[에러] " + e.getMessage());
        }

        return cartList;
    }

    @PostMapping("/join")
    public String join(HttpServletRequest request) {

        CustomerTO to = new CustomerTO();
        to.setEmail(request.getParameter("email"));
        to.setPwd(request.getParameter("pwd"));
        to.setAddr(request.getParameter("addr"));
        to.setZip(request.getParameter("zip"));

        String joinCk = customerDAO.emailCheck(to);

        return String.format("{\"joinCk\": \"%s\"}", joinCk);
    }

    @PostMapping( "/login")
    public String login(HttpServletRequest request) {

        CustomerTO to = new CustomerTO();
        to.setEmail(request.getParameter("email"));
        to.setPwd(request.getParameter("pwd"));

        int cid = customerDAO.loginCheck(to);

        return String.format("{\"cid\": \"%s\"}", cid);
    }

    // 로그인 성공 시, 세션 재생성 및 cid 삽입 로직
    @PostMapping("/emailSaveSession")
    public String emailSaveSession(HttpServletRequest request, HttpSession session) {

        HttpSession ordSession = request.getSession(false);     // false : 세션이 존재하면 반환하고, 없으면 null을 반환합니다.

        if (ordSession != null) { ordSession.invalidate(); }   // 기존 세션 무효화

        HttpSession newSession = request.getSession(true);      // true : 세션이 존재하지 않으면 새로운 세션을 생성하고 반환

        String cid = request.getParameter("cid");
        newSession.setAttribute("cid", cid);

        return String.format("{\"sessionStatus\": \"%s\"}", "success");
    }

    // 세션에 로그인 정보가 있는지 확인
    @GetMapping("/loginSessionCheck")
    public String loginSessionCheck(HttpSession session) {

        String loginStatus = "loginNo";

        String cid = (String) session.getAttribute("cid");

        if (cid != null) { loginStatus = "loginYes";}

        return String.format("{\"loginStatus\": \"%s\"}", loginStatus);
    }

    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return String.format("{\"logoutStatus\": \"%s\"}", "success");
    }

    //세션 방식 ( 사용 보류 )
//    @PostMapping("/cart")
    public String cartInSession(HttpSession session, HttpServletRequest request) {

        String pid = request.getParameter("pid");
        int num = Integer.parseInt(request.getParameter("num"));

        HashMap<String, ProductTO> map = (HashMap<String, ProductTO>) session.getAttribute("productMap");

        if (map == null) {
            // 세션에 productMap 없으면 새로 생성
            map = new HashMap<>();
        }

        if (!map.containsKey(pid)) {

            // productMap에 해당 상품이 없을 경우, 새로 생성
            ProductTO to = new ProductTO();
            to.setPid(pid);       // pid 설정
//            to.setPickNum(num);   // 수량 설정
            map.put(pid, to);

        } else {
            // productMap에 해당 상품이 있을 경우, 상품 수량 업데이트
            ProductTO to = map.get(pid);
//            to.setPickNum(num);   // 수량 업데이트
            map.put(pid, to);     // 수정된 값 다시 저장
        }
        // 업데이트한 productMap를 세션에 저장
        session.setAttribute("productMap", map);
        // 장바구니에 담은 상품 갯수
//        session.setAttribute("mapSize", map.size());
        String cartCount = String.valueOf(map.size());

        return "{ \"cartCount\" : " + cartCount + " }";
    }

}
