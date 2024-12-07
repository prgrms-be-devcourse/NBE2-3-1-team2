package com.example.project01.dao;

import com.example.project01.dto.PurchaseDateTO;
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

    public List<PurchaseTO> getPurchasesByDate(PurchaseDateTO date) {
        return purchaseMapper.selectByDate(date);
    }

    public Boolean updatePurchaseState(PurchaseTO purchaseTO) {
        return purchaseMapper.updatePurchaseState(purchaseTO) > 0;
    }

    public void updatePendingPurchases() {
        int result = 0;
        try {
            result = purchaseMapper.updatePendingPurchases();
            System.out.println("[안내] " + result + "개의 주문이 배송처리 되었습니다.");
        } catch (Exception e) {
            System.out.println(result);
            System.out.println("[에러] 배송 처리를 진행중에 시스템 에러가 발생했습니다. (" + e.getMessage() + ")");
        }
    }
}
