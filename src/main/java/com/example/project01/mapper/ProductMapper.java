package com.example.project01.mapper;

import com.example.project01.dto.ProductTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

@Mapper
public interface ProductMapper {

    ArrayList<ProductTO> product_list();
    ProductTO cart_list(ProductTO pid);

}
