package com.baizhi.service;

import com.baizhi.entity.GoodsCateinstore;
import com.baizhi.entity.PageBean;

import java.util.List;

public interface CateInStoreService {
    void addCate(String name);

    PageBean findAllCate(Integer pageNow,Integer pageCount);

    //添加商品时显示类别
    List<GoodsCateinstore> findAll();
}
