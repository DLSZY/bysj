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
    //搜索时根据店名模糊查询
    List<Business> findByBusiness(String item);
    //搜索时食品名，类别名模糊查询
    List<Business> findByGoods(String item);
    //根据订单查询
    Business findByOrder(String oid);
}