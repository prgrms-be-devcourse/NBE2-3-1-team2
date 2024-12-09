package com.example.project01.controller;

import com.example.project01.dao.*;
import com.example.project01.dto.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.net.URLDecoder;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class CoffeeApiController {
    @Autowired
    private CustomerDAO customerDAO;
    @Autowired
    private ProductDAO productDAO;
    @Autowired
    private PurchaseDAO purchaseDAO;
    @Autowired
    private PurchaseDetailDAO purchaseDetailDAO;
    @Autowired
    private ProductOrderDAO productOrderDAO;

    @GetMapping("/product")
    public ArrayList<ProductDTO> productList() {return productDAO.getProductList();}

    @GetMapping("/productById")
    public ArrayList<ProductDTO> productListById(@CookieValue(name = "cart", defaultValue="[]") Cookie cartData) {
        ObjectMapper objectMapper = new ObjectMapper();
        List pid = new ArrayList();
        try {
            List<CartItemDTO> cartItemDTOS = objectMapper.readValue(URLDecoder.decode(cartData.getValue()), objectMapper.getTypeFactory().constructCollectionType(List.class, CartItemDTO.class));
            for (CartItemDTO item : cartItemDTOS) pid.add(item.getProductId());
        } catch (IOException e) {
            System.out.println("ERROR : " + e.getMessage());
        }
        return productDAO.getProduct(pid);
    }

    @GetMapping("/orderList")
    public ArrayList<ProductOrderDTO> getOrderList(HttpSession session) {
        String cid = (String) session.getAttribute("cid");
        ArrayList<ProductOrderDTO> orderList = productOrderDAO.getProductOrderList(cid);
        return orderList;
    }

    @GetMapping("/orderList/{startDate}")
    public ArrayList<ProductOrderDTO> getOrderList(@PathVariable String startDate, HttpSession session) {
        // 주문 내역 JSON 형태로 변환
        Map date = new HashMap();
        String cid = (String) session.getAttribute("cid");
        date.put("cid", cid);
        date.put("startDate", LocalDate.now().minusDays(Integer.parseInt(startDate)).toString());
        date.put("endDate", LocalDate.now().plusDays(1).toString());
        System.out.println(LocalDate.now().minusDays(Integer.parseInt(startDate)).toString());
        ArrayList<ProductOrderDTO> orderList = productOrderDAO.getListAfterInputDate(date);
        return orderList;
    }

    @GetMapping("/orderList/{startDate}/{endDate}")
    public ArrayList<ProductOrderDTO> getOrderList(@PathVariable String startDate, @PathVariable String endDate, HttpSession session) {
        // 주문 내역 JSON 형태로 변환
        Map date = new HashMap();
        String cid = (String) session.getAttribute("cid");
        date.put("cid", cid);
        date.put("startDate", LocalDate.now().minusDays(Integer.parseInt(startDate)).toString());
        date.put("endDate", LocalDate.now().minusDays(Integer.parseInt(endDate)).plusDays(1).toString());
        ArrayList<ProductOrderDTO> orderList = productOrderDAO.getListAfterInputDate(date);
        return orderList;
    }

    @PostMapping("/join")
    public String join(@RequestBody CustomerDTO customerDTO) {
        int flag = customerDAO.insertCustomer(customerDTO);
        return "{\"flag\":\"" + flag + "\"}";
    }

    @PostMapping("/login")
    public String login(@RequestBody CustomerDTO customerDTO, HttpSession session) {
        int flag = customerDAO.isContainEmail(customerDTO);
        if (flag == 0) return "{\"flag\":\"-1\"}";
        String cid = customerDAO.selectCustomer(customerDTO);
        if (cid == null) return "{\"flag\":\"-2\"}";
        session.setAttribute("cid", cid);
        return "{\"flag\":\"1\"}";
    }

    @RequestMapping("/logout.do")
    public String logout(HttpSession session, HttpServletResponse response, RedirectAttributes redirectAttributes) throws IOException {
        session.invalidate();
        response.sendRedirect("/main.do");
        return "logout";
    }

    @PostMapping("/order")
    public String order(@RequestBody OrderDTO orderDTO) {
        CustomerDTO customerDTO = orderDTO.getCustomer();
        PurchaseDTO purchaseDTO = new PurchaseDTO(customerDTO.getCid(), LocalDateTime.now(), getFormattedDate(LocalDateTime.now()), customerDTO.getZip(), customerDTO.getAddr(), "1");
        int pFlag = purchaseDAO.insertPurchase(purchaseDTO);
        PurchaseDTO lastPurchase = purchaseDAO.lastPurchase();
        int pdFlag = 0;
        for ( CartDTO cartDTO : orderDTO.getProducts() ) {
            PurchaseDetailDTO purchaseDetailDTO = new PurchaseDetailDTO(lastPurchase.getPid(),
                    Integer.parseInt(cartDTO.getProductId()),
                    customerDTO.getCid(),
                    Integer.parseInt(cartDTO.getCount()),
                    productDAO.getPriceById(Integer.parseInt(cartDTO.getProductId())) * Integer.parseInt(cartDTO.getCount()));
            pdFlag += purchaseDetailDAO.insertPurchaseDetail(purchaseDetailDTO);
        }
        if (pdFlag == orderDTO.getProducts().size() && pFlag == 1) {return "{\"flag\":\"" + 1 + "\"}";}
        return "{\"flag\":\"-1\"}";
    }

    @PutMapping("/refund/{pid}")
    public String refund(@PathVariable String pid) {
        int flag = purchaseDAO.refundService(Integer.parseInt(pid));
        return Integer.toString(flag);
    }

    @DeleteMapping("/delete/{password}")
    public String delete(@PathVariable String password, HttpSession session) {
        String cid = (String) session.getAttribute("cid");
        Map data = new HashMap();
        data.put("cid", cid);
        data.put("password", password);
        int flag = customerDAO.deleteCustomer(data);
        if (flag == 1) session.invalidate();
        return Integer.toString(flag);
    }

    // 배송 시작일 계산
    public LocalDate getFormattedDate(LocalDateTime inputDate) {
        // 기준 날짜: 오후 2시부터 그 다음날 오후 1시 59분 59초
        LocalDateTime startOfPeriod = LocalDateTime.of(inputDate.toLocalDate(), java.time.LocalTime.of(14, 0, 0)).minusNanos(1L);
        LocalDateTime endOfPeriod = startOfPeriod.plusDays(1).plusNanos(1L);

        // 기준 날짜가 해당 범위 내에 포함되면 "YYYY-MM-DD" 형식으로 반환
        if (inputDate.isAfter(startOfPeriod) && inputDate.isBefore(endOfPeriod)) {
            return startOfPeriod.plusDays(1).toLocalDate(); // "YYYY-MM-DD"로 반환
        }

        // 범위 밖의 날짜는 해당 날짜의 "YYYY-MM-DD" 형식으로 반환
        return inputDate.toLocalDate(); // "YYYY-MM-DD"로 반환
    }
}
