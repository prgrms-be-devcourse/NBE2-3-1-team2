package com.example.project01.mapper;

import com.example.project01.dto.ProductTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface ProductMapper {

    ArrayList<ProductTO> lists();
    ProductTO cart_lists(String pid);
    String findImg(String pid);
}
