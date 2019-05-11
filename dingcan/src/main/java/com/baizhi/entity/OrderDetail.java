package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.Transient;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class OrderDetail {
    private String id;

    private String orderId;

    private String goodsId;

    private Integer goodsCount;

    @Transient
    private String goodsName;
    @Transient
    private Double goodsPrice;

}