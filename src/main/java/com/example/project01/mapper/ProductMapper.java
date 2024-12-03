package com.example.project01.mapper;

import com.example.project01.dto.ProductTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ProductMapper {
    List<ProductTO> selectAll();
    ProductTO selectById(String pid);
}
