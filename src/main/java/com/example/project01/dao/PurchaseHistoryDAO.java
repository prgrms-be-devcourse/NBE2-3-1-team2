package com.example.project01.dao;

import com.example.project01.dto.PurchaseHistoryTO;
import com.example.project01.mapper.ProductMapper;
import com.example.project01.mapper.PurchaseHistoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public class PurchaseHistoryDAO {
    @Autowired
    private PurchaseHistoryMapper purchaseHistoryMapper;

    @Autowired
    private ProductMapper productMapper;

    public ArrayList<PurchaseHistoryTO> historys(String cid) {
        return purchaseHistoryMapper.history(cid);
    }

    public String findImg(String pid) {
        return productMapper.findImg(pid);
    }

    public int refund(String pid){
        return purchaseHistoryMapper.refund(pid);
    }
}
