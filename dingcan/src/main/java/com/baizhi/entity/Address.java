package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Address {
    private String id;

    private String name;

    private Integer provinceId;

    private Integer cityId;

    private Integer countyId;

    private String address;

    private String phone;

    private String userId;
}