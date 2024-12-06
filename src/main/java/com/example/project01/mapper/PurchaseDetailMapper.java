package com.example.project01.mapper;

import com.example.project01.dto.PurchaseDetailTO;
import com.example.project01.dto.PurchaseProductDetailTO;
import com.example.project01.dto.request.ReqOrderTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PurchaseDetailMapper {
    void insertDetail(ReqOrderTO orders);
    List<PurchaseProductDetailTO> selectByOrderId(int pid);
}
