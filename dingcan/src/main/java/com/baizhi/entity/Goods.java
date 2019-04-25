package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Goods {
    private String id;

    private String businessId;

    private String cateId;

    private String cateinstoreId;

    private String name;

    private Long price;

    private String imgUrl;

    private String description;

    private Integer saleCount;
}