package com.baizhi.service;

import com.baizhi.entity.GoodsCate;
import com.baizhi.entity.PageBean;

import java.util.List;

public interface CategoryService {
    //添加商品类别
    void add(GoodsCate cate);
    //分页查询类别
    PageBean select(Integer level,Integer page,Integer rows);
    //查询类别
    List<GoodsCate> findCateByLevel(Integer level);
    //删除二级分类
    void deleteSecond(String id);
    //删除一级类别
    void deleteFirst(String id);
    //根据以及类别名查询其下的二级类别
    List<GoodsCate> selectByFistName(String firstName);
}
