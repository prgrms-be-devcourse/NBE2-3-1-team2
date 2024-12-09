package com.example.project01.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.ToString;

@ToString
public class CartItemDTO {

    private long timestamp;

    @JsonProperty("productId")  // JSON의 "ProductId"를 Java 필드 "productId"와 매핑
    private String productId;

    private String count;

    public CartItemDTO() {
    }

    public CartItemDTO(long timestamp, String productId, String count) {
        this.timestamp = timestamp;
        this.productId = productId;
        this.count = count;
    }

    // Getter와 Setter 메서드
    public long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
    }
}