package com.example.project01.dto.response;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class RespCollectionTO<E> {
    private boolean success;
    private String message;
    private List<E> data;
}
