package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.Id;
import javax.persistence.Transient;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ShopCart {
    @Id
    private String id;

    private String goodsId;

    private Integer goodsCount;

    private String userId;


    @Transient
    private String businessId;
    @Transient
    private String goodsName;
    @Transient
    private Double goodsPrice;
}