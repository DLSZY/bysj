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
public class OrderMaster {
    private String id;

    private String userId;

    private String addressId;

    private String orderNum;

    private Date createDate;

    private Long orderAmount;

    private Integer status;

    private String userRemarks;

    private Integer payStatus;
}