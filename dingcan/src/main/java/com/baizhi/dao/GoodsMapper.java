package com.baizhi.dao;


import com.baizhi.entity.Goods;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;


public interface GoodsMapper  extends Mapper<Goods> {
    List<Goods> findGood(String businessId);

    Goods findOne(String id);

    List<Goods> findAll();
}