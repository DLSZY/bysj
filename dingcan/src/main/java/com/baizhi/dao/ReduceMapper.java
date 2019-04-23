package com.baizhi.dao;

import com.baizhi.entity.Reduce;
import java.util.List;

public interface ReduceMapper {
    int deleteByPrimaryKey(String id);

    int insert(Reduce record);

    Reduce selectByPrimaryKey(String id);

    List<Reduce> selectAll();

    int updateByPrimaryKey(Reduce record);
}