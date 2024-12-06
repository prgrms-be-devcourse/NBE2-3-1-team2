package com.example.project01.dao;

import com.example.project01.dto.PurchaseProductDetailTO;
import com.example.project01.dto.request.ReqOrderTO;
import com.example.project01.mapper.PurchaseDetailMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PurchaseDetailDAO {
    PurchaseDetailMapper detailMapper;

    @Autowired
    public PurchaseDetailDAO(PurchaseDetailMapper detailMapper) {
        this.detailMapper = detailMapper;
    }

    public void insertPurchaseDetail(ReqOrderTO order) {
        detailMapper.insertDetail(order);
    }

    public List<PurchaseProductDetailTO> getPurchaseDetailByPurchaseId(int pid) {
        return detailMapper.selectByOrderId(pid);
    }

}
