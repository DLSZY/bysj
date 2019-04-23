package com.baizhi.dao;

import com.baizhi.entity.ShopCart;
import java.util.List;

public interface ShopCartMapper {
    int deleteByPrimaryKey(String id);

    int insert(ShopCart record);

    ShopCart selectByPrimaryKey(String id);

    List<ShopCart> selectAll();

    int updateByPrimaryKey(ShopCart record);
}