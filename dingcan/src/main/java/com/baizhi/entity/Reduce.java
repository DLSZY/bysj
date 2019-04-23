package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Reduce {
    private String id;

    private String businessId;

    private Long achieveMoney;

    private Long reduceMoney;

}