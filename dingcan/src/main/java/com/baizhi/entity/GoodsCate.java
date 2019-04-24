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
public class GoodsCate {
    @Id
    private String id;

    private String name;

    private Integer level;

    private String parentId;

    private String parentName;
}