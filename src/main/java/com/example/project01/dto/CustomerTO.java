package com.example.project01.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CustomerTO {
    private int id;
    private String email;
    private String pwd;
    private String addr;
    private String zip;
}
