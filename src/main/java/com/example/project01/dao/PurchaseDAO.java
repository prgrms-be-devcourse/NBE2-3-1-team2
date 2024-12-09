package com.example.project01.dao;

import com.example.project01.dto.PurchaseDetailTO;
import com.example.project01.dto.PurchaseTO;
import com.example.project01.mapper.PurchaseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PurchaseDAO {
    @Autowired
    private PurchaseMapper purchaseMapper;



    public int purchase(PurchaseTO to) {

        return purchaseMapper.purchase(to);
    }

    public int detail(PurchaseDetailTO detail) {

        return purchaseMapper.detail(detail);
    }

    public void updatePendingPurchase() {
        purchaseMapper.updatePendingPurchase();
    }

}
