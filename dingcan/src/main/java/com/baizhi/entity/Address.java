package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.Id;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Address {
    @Id
    private String id;

    private String userId;

    private String name;

    private Integer sex;

    private String phone;

    private String address;

    private String houseNum;

    private Integer def;
}