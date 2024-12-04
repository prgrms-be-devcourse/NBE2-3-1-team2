package com.example.project01.dao;

import com.example.project01.mapper.PurchaseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PurchaseDAO {
    @Autowired
    private PurchaseMapper purchaseMapper;
}
