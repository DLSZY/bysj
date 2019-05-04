package com.baizhi.service;

import com.baizhi.entity.GoodsCateinstore;
import com.baizhi.entity.PageBean;

import java.util.List;

public interface CateInStoreService {
    void addCate(String name);

    //分页查询所有
    PageBean findAllCate(Integer pageNow,Integer pageCount);

    //添加商品时显示类别
    List<GoodsCateinstore> findAll();

    //删除
    void delete(String id);
}
