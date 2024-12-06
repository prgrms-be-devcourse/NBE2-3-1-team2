package com.example.project01.dao;

import com.example.project01.dto.CustomerTO;
import com.example.project01.dto.PurchaseTO;
import com.example.project01.mapper.PurchaseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public class PurchaseDAO {
    @Autowired
    private PurchaseMapper purchaseMapper;

    public int purchaseInfo(PurchaseTO purchaseTO) {
        return purchaseMapper.purchase_info(purchaseTO);
    }
}
