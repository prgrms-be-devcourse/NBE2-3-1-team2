package com.example.project01.mapper;

import com.example.project01.dto.ProductTO;
import com.example.project01.dto.UserCartTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ProductMapper {
    List<ProductTO> selectAll();
    List<UserCartTO> selectByIds(@Param("ids") List<Integer> ids);
//    int selectPriceById(int pid);
}
