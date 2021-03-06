package com.baizhi.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.Transient;
import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Comment {
    private String id;

    private String userId;

    private String orderId;

    private String businessId;

    private String content;

    private Integer goodsGrade;

    private Integer packageGrade;

    private Integer distributeGrade;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:dd",timezone = "GMT+8")
    private Date createDate;

    @Transient
    private String orderNum;
    @Transient
    private String username;
    @Transient
    private String imgUrl;
    @Transient
    private Double average;
    @Transient
    private StringBuffer goodNames;
}