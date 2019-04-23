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
public class Comment {
    private String id;

    private String userId;

    private String goodsId;

    private String businessId;

    private String content;

    private Integer goodsGrade;

    private Integer packageGrade;

    private Integer distributeGrade;

    private Date createDate;
}