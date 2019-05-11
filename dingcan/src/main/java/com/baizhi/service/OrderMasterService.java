package com.baizhi.service;

import com.baizhi.entity.OrderMaster;
import com.baizhi.entity.PageBean;

import java.util.List;

public interface OrderMasterService {

    /**
     * 用户
     */
    //添加
    void add(OrderMaster orderMaster);

    /**
     * 管理员
     */
    //查询所有
    PageBean findByPage(Integer pageNow, Integer pageCount);
}
