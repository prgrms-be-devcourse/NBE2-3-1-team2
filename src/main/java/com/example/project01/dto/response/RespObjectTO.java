package com.example.project01.dto.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RespObjectTO<T> {
    private boolean success;
    private String message;
    private T data;
}
