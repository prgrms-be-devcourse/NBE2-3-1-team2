package com.example.project01.controller;

import com.example.project01.dao.PurchaseDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class ScheduledTask {
    private final PurchaseDAO purchaseDAO;

    public ScheduledTask(PurchaseDAO purchaseDAO) {
        this.purchaseDAO = purchaseDAO;
    }
    @Scheduled(cron = "0 0 14 * * ?")
    public void deleteProductOrder() {
        try {
            purchaseDAO.updateStatus();
            System.out.println("updateStatus 작업 완료");
        } catch (Exception e) {
            System.err.println("updateStatus 작업 실패: " + e.getMessage());
        }
    }

}
