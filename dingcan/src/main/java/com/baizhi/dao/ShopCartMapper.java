package com.baizhi.dao;

import com.baizhi.entity.Admin;
import com.baizhi.entity.ShopCart;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface ShopCartMapper  extends Mapper<ShopCart> {

    List<ShopCart> findByUser(String uid);

    List<ShopCart> findByUserAndBusiness(@Param("uid") String uid, @Param("bid") String bid);

}