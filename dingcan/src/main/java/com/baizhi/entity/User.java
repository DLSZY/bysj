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
public class User {
    private String id;

    private String username;

    private String password;

    private String phone;

    private String imgUrl;

    private Date register;

    private Date lastlogintime;

    private String salt;

}