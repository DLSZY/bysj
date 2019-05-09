package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cart {
    private String businessId;

    private String businessName;

    private List<ShopCart> Items;

    private Double startPrice;

    private List<Reduce> reduces;

    private Double distributeFee;
}
