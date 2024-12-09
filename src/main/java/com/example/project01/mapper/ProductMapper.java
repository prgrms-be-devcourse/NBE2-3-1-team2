package com.example.project01.mapper;

import com.example.project01.dto.ProductDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.List;

@Mapper
public interface ProductMapper {
    ArrayList<ProductDTO> selectAllProduct();
    ArrayList<ProductDTO> selectProduct(List pid);
    int getPriceById(int pid);
}
