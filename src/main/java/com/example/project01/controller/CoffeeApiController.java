package com.example.project01.controller;

import com.example.project01.dao.ProductDAO;
import com.example.project01.dto.ProductTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;

@RestController
@RequestMapping("/api")
public class CoffeeApiController {

    @Autowired
    private ProductDAO productDAO;

    @GetMapping("/productList")
    public ArrayList<ProductTO> productList() {
        return productDAO.productAll();
    }

    @PostMapping("/cart")
    public String cartIn(HttpSession session, HttpServletRequest request) {

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
            to.setPickNum(num);   // 수량 설정
            map.put(pid, to);

        } else {
            // productMap에 해당 상품이 있을 경우, 상품 수량 업데이트
            ProductTO to = map.get(pid);
            to.setPickNum(num);   // 수량 업데이트
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
