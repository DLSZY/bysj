package com.baizhi.dao;

import com.baizhi.entity.Admin;
import com.baizhi.entity.GoodsCateinstore;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface GoodsCateinstoreMapper extends Mapper<GoodsCateinstore> {
    //查询本店类别并查询类别下的食物
    List<GoodsCateinstore> findByBusiness(String bid);
}