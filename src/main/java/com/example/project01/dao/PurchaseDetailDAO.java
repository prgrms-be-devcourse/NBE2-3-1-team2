package com.example.project01.dao;

import com.example.project01.mapper.PurchaseDetailMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PurchaseDetailDAO {
    PurchaseDetailMapper detailMapper;

    @Autowired
    public PurchaseDetailDAO(PurchaseDetailMapper detailMapper) {
        this.detailMapper = detailMapper;
    }
}
