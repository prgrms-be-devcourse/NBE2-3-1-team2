package com.example.project01.dao;

import com.example.project01.dto.PurchaseTO;
import com.example.project01.dto.request.ReqOrderTO;
import com.example.project01.mapper.PurchaseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PurchaseDAO {
    PurchaseMapper purchaseMapper;

    @Autowired
    public PurchaseDAO(PurchaseMapper purchaseMapper) {
        this.purchaseMapper = purchaseMapper;
    }

    public void insertOrder(ReqOrderTO reqOrderTO) {
        purchaseMapper.insertOrder(reqOrderTO);
    }

    public List<PurchaseTO> getPurchasesByCustomerId(int cid) {
        return purchaseMapper.selectByCustomerId(cid);
    }
}
