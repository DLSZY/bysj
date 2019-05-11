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
public class User {
    @Id
    private String id;

    private String username;

    private String password;

    private String phone;

    private String imgUrl;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:dd",timezone = "GMT+8")
    private Date register;

    private String salt;

    private Integer status;

}