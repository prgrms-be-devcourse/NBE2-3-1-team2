package com.example.project01.dao;

import com.example.project01.dto.PurchaseDTO;
import com.example.project01.mapper.PurchaseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PurchaseDAO {
    @Autowired
    private PurchaseMapper purchaseMapper;

    public PurchaseDTO lastPurchase() {return purchaseMapper.lastPurchase();}
    public int insertPurchase(PurchaseDTO dto) {return purchaseMapper.insertPurchase(dto);}
    public int refundService(int pid) {return purchaseMapper.updatePurchase(pid);}
    public void updateStatus() {purchaseMapper.updateStatus();}
}
