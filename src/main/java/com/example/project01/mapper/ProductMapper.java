package com.example.project01.mapper;

import com.example.project01.dto.ProductDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface ProductMapper {
    ArrayList<ProductDTO> selectAllProduct();
}
