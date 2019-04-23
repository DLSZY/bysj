package com.baizhi.dao;

import com.baizhi.entity.GoodsCate;
import java.util.List;

public interface GoodsCateMapper {
    int deleteByPrimaryKey(String id);

    int insert(GoodsCate record);

    GoodsCate selectByPrimaryKey(String id);

    List<GoodsCate> selectAll();

    int updateByPrimaryKey(GoodsCate record);
}