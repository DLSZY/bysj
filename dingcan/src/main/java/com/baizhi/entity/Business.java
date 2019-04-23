package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Business {
    private String id;

    private String username;

    private String password;

    private String name;

    private Integer provinceId;

    private Integer cityId;

    private Integer countyId;

    private String address;

    private String phone;

    private Date registerTime;

    private Long startPrice;

    private Long distributionFee;
}