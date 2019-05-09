package com.baizhi.service;

import com.baizhi.entity.Cart;
import com.baizhi.entity.ShopCart;

import java.util.List;
import java.util.Map;

public interface CartService {
    //添加购物车条例
    void add(ShopCart shopCart);
    //查询当前用户的购物车
    List<Cart> findCartByUser(String uid);
    //修改购物车商品数量
    void editCount(String cid,String option);
}
