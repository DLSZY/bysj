package com.baizhi.service;

import com.baizhi.entity.GoodsCateinstore;
import com.baizhi.entity.PageBean;

import java.util.List;

public interface CateInStoreService {
    void addCate(String name,String businessId);

    //分页查询所有
    PageBean findAllCate(Integer pageNow,Integer pageCount,String businessId);

    //添加商品时显示类别
    List<GoodsCateinstore> findAll(String businessId);

    //删除
    void delete(String id);
}
