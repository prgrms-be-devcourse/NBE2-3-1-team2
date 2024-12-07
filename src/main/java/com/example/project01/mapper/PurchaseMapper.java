package com.example.project01.mapper;

import com.example.project01.dto.PurchaseDateTO;
import com.example.project01.dto.PurchaseTO;
import com.example.project01.dto.request.ReqOrderTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PurchaseMapper {
    void insertOrder(ReqOrderTO order);
    List<PurchaseTO> selectByCustomerId(int cid);
    List<PurchaseTO> selectByDate(PurchaseDateTO date);
    int updatePurchaseState(PurchaseTO purchase);
    int updatePendingPurchases();
}
