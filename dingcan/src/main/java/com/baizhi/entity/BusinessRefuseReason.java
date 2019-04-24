package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BusinessRefuseReason {
    private String id;
    private String businessId;
    private String reason;
    private Date createDate;
}
