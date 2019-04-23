package com.baizhi.dao;

import com.baizhi.entity.Goods;
import java.util.List;

public interface GoodsMapper {
    int deleteByPrimaryKey(String id);

    int insert(Goods record);

    Goods selectByPrimaryKey(String id);

    List<Goods> selectAll();

    int updateByPrimaryKey(Goods record);
}