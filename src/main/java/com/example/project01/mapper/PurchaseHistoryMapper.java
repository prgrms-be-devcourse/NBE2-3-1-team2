package com.example.project01.mapper;

import com.example.project01.dto.PurchaseHistoryTO;
import com.example.project01.dto.PurchaseTO;
import org.apache.ibatis.annotations.Mapper;

import java.lang.reflect.Array;
import java.util.ArrayList;

@Mapper
public interface PurchaseHistoryMapper {
    ArrayList<PurchaseHistoryTO> purchaseHistoryInfo(String email);
}
