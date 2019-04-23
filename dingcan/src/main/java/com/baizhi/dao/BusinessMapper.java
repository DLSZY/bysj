package com.baizhi.dao;

import com.baizhi.entity.Business;
import java.util.List;

public interface BusinessMapper {
    int deleteByPrimaryKey(String id);

    int insert(Business record);

    Business selectByPrimaryKey(String id);

    List<Business> selectAll();

    int updateByPrimaryKey(Business record);
}