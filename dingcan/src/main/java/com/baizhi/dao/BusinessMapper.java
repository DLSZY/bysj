package com.baizhi.dao;

import com.baizhi.entity.Admin;
import com.baizhi.entity.Business;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface BusinessMapper extends Mapper<Business> {
    //根据一级类别查询店
    List<Business> findByFirst(String cateName);
    //根据二级类别查询店
    List<Business> findBySecond(String cateName);
}