package com.example.project01.dao;

import com.example.project01.dto.PurchaseHistoryTO;
import com.example.project01.mapper.PurchaseHistoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public class PurchaseHistoryDAO {
    @Autowired
    private PurchaseHistoryMapper purchaseHistoryMapper;

    public ArrayList<PurchaseHistoryTO> purchaseHistoryList(String email){
        return purchaseHistoryMapper.purchaseHistoryInfo(email);
    }
}
