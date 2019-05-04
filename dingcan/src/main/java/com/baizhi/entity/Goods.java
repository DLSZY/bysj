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
public class Goods {
    @Id
    private String id;

    private String businessId;
    @Transient
    private String businessName;

    private String cateId;

    @Transient
    private String cateName;

    private String cateinstoreId;

    @Transient
    private String cateinstoreName;

    private String name;

    private Long price;

    private String imgUrl;

    private String description;

    private Integer saleCount;
}