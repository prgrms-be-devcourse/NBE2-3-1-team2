package com.example.project01.service;

import com.example.project01.dao.CustomerDAO;
import com.example.project01.dao.ProductDAO;
import com.example.project01.dao.PurchaseDAO;
import com.example.project01.dao.PurchaseDetailDAO;
import com.example.project01.dto.CustomerTO;
import com.example.project01.dto.PurchaseDateTO;
import com.example.project01.dto.PurchaseProductDetailTO;
import com.example.project01.dto.PurchaseTO;
import com.example.project01.dto.request.ReqDateTO;
import com.example.project01.dto.request.ReqOrderTO;
import com.example.project01.dto.response.RespMessageTO;
import com.example.project01.dto.response.RespOrderHistoryTO;
import com.example.project01.enums.OrderStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class OrderService {

    private final PurchaseDAO purchaseDAO;
    private final CustomerDAO customerDAO;
    private final ProductDAO productDAO;
    private final PurchaseDetailDAO purchaseDetailDAO;

    @Autowired
    public OrderService(PurchaseDAO purchaseDAO, CustomerDAO customerDAO, ProductDAO productDAO, PurchaseDetailDAO purchaseDetailDAO) {
        this.purchaseDAO = purchaseDAO;
        this.customerDAO = customerDAO;
        this.productDAO = productDAO;
        this.purchaseDetailDAO = purchaseDetailDAO;
    }

    private Timestamp calculateTime(Timestamp ot) {
        LocalDateTime orderTime = ot.toLocalDateTime();
        LocalTime baseTime = LocalTime.of(14,0);

        if (orderTime.toLocalTime().isBefore(baseTime)) {
            return Timestamp.valueOf(orderTime.toLocalDate().atTime(baseTime));
        } else {
            return Timestamp.valueOf(orderTime.toLocalDate().plusDays(1).atTime(baseTime));
        }
    }


    public RespMessageTO addOrderList(ReqOrderTO reqOrderTO) {
        RespMessageTO respMessageTO = new RespMessageTO();

        try {
            reqOrderTO.setCustomer(customerDAO.selectCustomerByEmail(reqOrderTO.getCustomer().getEmail()));
            reqOrderTO.setProducts(productDAO.selectCartList(reqOrderTO.getProducts()));

            PurchaseTO purchase = new PurchaseTO();

            purchase.setCid(reqOrderTO.getCustomer().getCid());
            Timestamp ot = Timestamp.valueOf(LocalDateTime.now());
            Timestamp sst = calculateTime(ot);
            purchase.setOt(ot);
            purchase.setSst(sst);
            purchase.setAddr(reqOrderTO.getCustomer().getAddr());
            purchase.setZip(reqOrderTO.getCustomer().getZip());
            purchase.setSt(OrderStatus.PENDING.getDesc());
            reqOrderTO.setPurchase(purchase);
            purchaseDAO.insertOrder(reqOrderTO);
            reqOrderTO.setPurchase(purchase);

            purchaseDetailDAO.insertPurchaseDetail(reqOrderTO);

            respMessageTO.setSuccess(true);
        } catch (Exception e) {
            respMessageTO.setSuccess(false);
            respMessageTO.setMessage("주문에 실패했습니다.");
        }

        return respMessageTO;
    }

    public RespOrderHistoryTO getOrderHistory(String email) {
        RespOrderHistoryTO resp = new RespOrderHistoryTO();
        CustomerTO customer = customerDAO.selectCustomerByEmail(email);
        resp.setPurchase(purchaseDAO.getPurchasesByCustomerId(customer.getCid()));
        List<List<PurchaseProductDetailTO>> lists = new ArrayList<>();
        resp.getPurchase().forEach(item ->
            lists.add(purchaseDetailDAO.getPurchaseDetailByPurchaseId(item.getPid()))
        );
        resp.setLists(lists);

        resp.setSuccess(true);

        return resp;
    }

    public RespOrderHistoryTO getOrderHistoryByDate(PurchaseDateTO date) {
        RespOrderHistoryTO resp = new RespOrderHistoryTO();
        CustomerTO customer = customerDAO.selectCustomerByEmail(date.getEmail());
        date.setCid(customer.getCid());
        resp.setPurchase(purchaseDAO.getPurchasesByDate(date));

        List<List<PurchaseProductDetailTO>> lists = new ArrayList<>();
        resp.getPurchase().forEach(item ->
                lists.add(purchaseDetailDAO.getPurchaseDetailByPurchaseId(item.getPid()))
        );
        resp.setLists(lists);

        resp.setSuccess(true);

        return resp;
    }

    public RespMessageTO setRefund(PurchaseTO purchase) {
        RespMessageTO resp = new RespMessageTO();

        purchase.setSt(OrderStatus.CANCELED.getDesc());

        boolean trigger = purchaseDAO.updatePurchaseState(purchase);

        if (trigger) {
            resp.setSuccess(true);
        } else {
            resp.setSuccess(false);
            resp.setMessage("이미 환불된 상품입니다.");
        }

        return resp;
    }
}
