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
    //查询当前用户订单
    List<OrderMaster> findByUser(String uid);
    //删除订单（改变订单状态）
    void del(String oid);

    /**
     * 管理员
     */
    //查询所有
    PageBean findByPage(Integer pageNow, Integer pageCount,String bid);
    //根据id查询
    OrderMaster findById(String oid);
}
