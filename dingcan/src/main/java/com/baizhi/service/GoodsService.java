package com.baizhi.service;

import com.baizhi.entity.Goods;
import com.baizhi.entity.PageBean;

public interface GoodsService {

    //添加食品
    void add(Goods goods);
    //分页查询本店食品
}
