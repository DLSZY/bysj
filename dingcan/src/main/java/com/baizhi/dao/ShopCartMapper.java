package com.baizhi.dao;

import com.baizhi.entity.Admin;
import com.baizhi.entity.ShopCart;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface ShopCartMapper  extends Mapper<ShopCart> {

    List<ShopCart> findByUser(String uid);

}