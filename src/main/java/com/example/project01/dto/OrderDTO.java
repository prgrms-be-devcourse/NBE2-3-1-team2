package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class OrderDTO {
    private CustomerDTO customer;
    private List<CartDTO> products;
}
