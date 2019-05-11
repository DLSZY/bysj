package com.baizhi.dao;

import com.baizhi.entity.Admin;
import com.baizhi.entity.OrderDetail;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface OrderDetailMapper extends Mapper<OrderDetail> {
    //插入订单项
    void addDetails(List<OrderDetail> orderDetails);
    //查询订单项和食品名
    List<OrderDetail> findByOrder(String oid);
}