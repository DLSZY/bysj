package com.baizhi.service;

import com.baizhi.entity.Goods;
import com.baizhi.entity.PageBean;

public interface GoodsService {

    /*
    * 商家
    * */
    //添加食品
    void add(Goods goods);
    //修改食品信息
    void update(Goods goods);
    //分页查询本店食品
    PageBean findFood(Integer page,Integer rows,String businessId);
    //查看商品详情
    Goods findOne(String id);
    //删除商品
    void delete(String id);

    /**
     *管理员
     */
    //查询所有商品
    PageBean findAll(Integer page,Integer rows);
}
