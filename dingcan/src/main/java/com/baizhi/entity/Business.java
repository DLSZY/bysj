package com.baizhi.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.Id;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Business {
    @Id
    private String id;

    private String username;

    private String password;

    private String name;

    private String provinceCode;

    private String cityCode;

    private String areaCode;

    private String address;

    private String phone;

    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    private Date registerTime;

    private Double startPrice;

    private Double distributionFee;

    private Integer registerStatus;

    private Integer status;

}