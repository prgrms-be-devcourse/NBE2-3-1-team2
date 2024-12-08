package com.example.project01.service;

import com.example.project01.dao.CustomerDAO;
import com.example.project01.dao.ProductDAO;
import com.example.project01.dao.PurchaseDAO;
import com.example.project01.dao.PurchaseDetailDAO;
import com.example.project01.dto.*;
import com.example.project01.dto.request.ReqOrderTO;
import com.example.project01.dto.response.RespDashBoardTO;
import com.example.project01.dto.response.RespMessageTO;
import com.example.project01.dto.response.RespOrderHistoryTO;
import com.example.project01.enums.OrderStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class DashBoardService {

    private final PurchaseDAO purchaseDAO;
    private final CustomerDAO customerDAO;
    private final ProductDAO productDAO;
    private final PurchaseDetailDAO purchaseDetailDAO;

    @Autowired
    public DashBoardService(PurchaseDAO purchaseDAO, CustomerDAO customerDAO, ProductDAO productDAO, PurchaseDetailDAO purchaseDetailDAO) {
        this.purchaseDAO = purchaseDAO;
        this.customerDAO = customerDAO;
        this.productDAO = productDAO;
        this.purchaseDetailDAO = purchaseDetailDAO;
    }

    private List<List<PurchaseJoinDetailTO>> groupByDate(List<PurchaseJoinDetailTO> allData) {
        Map<String, List<PurchaseJoinDetailTO>> groupedByDate = allData.stream()
                .collect(Collectors.groupingBy(item -> item.getOt().toString()));

        List<List<PurchaseJoinDetailTO>> details = new ArrayList<>();
        groupedByDate.forEach((key, value) -> {
            details.add(value);
        });
        return details;
    }

    public RespDashBoardTO getDashboard() {
        RespDashBoardTO resp = new RespDashBoardTO();
        List<PurchaseJoinDetailTO> allData = purchaseDAO.getCompletedPurchases();
        List<CalculatedSalesTO> groupCalData = new ArrayList<>();


        List<List<PurchaseJoinDetailTO>> lists = groupByDate(allData);

        String now = String.valueOf(LocalDate.now());

        long previousSales = 0L;
        double increase = 0;

        for (int i = lists.size() - 1; i >= 0; i--) {
            List<PurchaseJoinDetailTO> list = lists.get(i);
            CalculatedSalesTO cal = new CalculatedSalesTO();
            int sold = 0;
            long sales = 0L;

            for (PurchaseJoinDetailTO item : list) {
                sold += item.getQty();
                sales += item.getPrice();
            }

            if (i < lists.size() - 1) {
                if (previousSales > 0) {
                    increase =  ((double)(sales - previousSales) / previousSales) * 100;
                } else {
                    increase = 0;
                }
            } else {
                increase = 0;
            }

            cal.setDate(list.get(i).getOt());
            cal.setSold(sold);
            cal.setSales(sales);
            cal.setIncrease(increase);

            previousSales = sales;

            groupCalData.add(cal);
        }

        resp.setPurchase(groupCalData);

        if(now.equals(groupCalData.get(groupCalData.size()-1).getDate().toString())){
            resp.setTotalProduct(groupCalData.get(groupCalData.size()-1).getSold());
            resp.setTodaySales(groupCalData.get(groupCalData.size()-1).getSales());
        } else {
            resp.setTotalProduct(0);
            resp.setTodaySales(0L);
        }

        resp.setTotalCustomer(customerDAO.countCustomers());

        resp.setSuccess(true);

        return resp;
    }
}
