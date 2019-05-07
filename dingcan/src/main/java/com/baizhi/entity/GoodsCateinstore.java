package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.Id;
import javax.persistence.Transient;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class GoodsCateinstore {
    @Id
    private String id;

    private String name;

    private String businessId;

    @Transient
    List<Goods> goodss;
}