package com.baizhi.service;

import com.baizhi.entity.Address;

import java.util.List;

public interface UserAddressService {
    /**
     * 用户
     */
    //添加
    void add(Address address);

    //查询该用户下的地址信息
    List<Address> findByUser(String uid);

    //根据地址id查询地址
    Address findById(String id);

    //修改地址信息
    void Update(Address address);

    //删除地址
    void del(String id);

}
