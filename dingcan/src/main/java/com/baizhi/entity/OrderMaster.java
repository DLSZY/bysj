package com.baizhi.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.Id;
import javax.persistence.Transient;
import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class OrderMaster {
    @Id
    private String id;

    private String userId;

    private String addressId;

    private String orderNum;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createDate;

    private Double orderAmount;

    private Integer status;

    private String userRemarks;

    private Integer isComment;

    private String businessId;
    @Transient
    private String businessName;
    @Transient
    private String username;
    @Transient
    private List<OrderDetail> orderdetails;
}