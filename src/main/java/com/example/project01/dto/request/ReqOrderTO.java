package com.example.project01.dto.request;

import com.example.project01.dto.CustomerTO;
import com.example.project01.dto.PurchaseTO;
import com.example.project01.dto.UserCartTO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

import java.util.List;

@Getter
@Setter
@ToString
@Alias("order")
public class ReqOrderTO{
    private CustomerTO customer;
    private PurchaseTO purchase;
    private List<UserCartTO> products;
}
