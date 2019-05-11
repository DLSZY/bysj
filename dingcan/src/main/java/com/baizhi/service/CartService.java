package com.baizhi.service;

import com.baizhi.entity.Cart;
import com.baizhi.entity.OrderDetail;
import com.baizhi.entity.ShopCart;

import java.util.List;
import java.util.Map;

public interface CartService {
    //添加购物车条例
    void add(ShopCart shopCart);
    //查询当前用户的购物车
    List<Cart> findCartByUser(String uid);
    //根据用户和商家联合查询购物车
    List<ShopCart> findByUserAndBusid(String uid,String bid);
    //修改购物车商品数量
    void editCount(String cid,String option);
    //订单完成，删除购物车数据
    void delete(String uid,String bid);


}
