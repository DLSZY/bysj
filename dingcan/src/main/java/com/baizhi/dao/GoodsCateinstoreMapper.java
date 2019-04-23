package com.baizhi.dao;

import com.baizhi.entity.GoodsCateinstore;
import java.util.List;

public interface GoodsCateinstoreMapper {
    int deleteByPrimaryKey(String id);

    int insert(GoodsCateinstore record);

    GoodsCateinstore selectByPrimaryKey(String id);

    List<GoodsCateinstore> selectAll();

    int updateByPrimaryKey(GoodsCateinstore record);
}