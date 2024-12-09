package com.example.project01.mapper;

import com.example.project01.dto.PurchaseHistoryTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.Map;

@Mapper
public interface PurchaseHistoryMapper {

    ArrayList<PurchaseHistoryTO> history(String cid);
    int refund(String pid);
}
