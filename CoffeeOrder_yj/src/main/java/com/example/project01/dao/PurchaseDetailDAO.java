package com.example.project01.dao;

import com.example.project01.dto.PurchaseDetailTO;
import com.example.project01.mapper.PurchaseDetailMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

@Repository
public class PurchaseDetailDAO {
    @Autowired
    private PurchaseDetailMapper purchaseDetailMapper;
    public int purchaseDetail(PurchaseDetailTO purchaseDetailTO) {
        return purchaseDetailMapper.purchaseDetailInfo(purchaseDetailTO);
    }
}
