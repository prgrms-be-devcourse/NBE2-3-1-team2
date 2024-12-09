package com.example.project01.controller;

import com.example.project01.dao.PurchaseDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class ScheduledTask {

    private PurchaseDAO purchaseDAO;

    @Autowired
    public ScheduledTask(PurchaseDAO purchaseDAO) {
        this.purchaseDAO = purchaseDAO;
    }

    @Scheduled(cron = "0 0 14 * * ?")
    public void scheduledTask() {
        purchaseDAO.updatePendingPurchase();
    }
}
