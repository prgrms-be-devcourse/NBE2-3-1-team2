package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter
@Setter
@ToString
public class CartDTO {
    private String productId;
    private String timestamp;
    private String count;
}
