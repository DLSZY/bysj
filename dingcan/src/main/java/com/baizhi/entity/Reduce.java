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
public class Reduce {
    @Id
    private String id;

    private String businessId;

    private Long achieveMoney;

    private Long reduceMoney;
}