package com.baizhi.service;

import com.baizhi.entity.OrderDetail;

import java.util.List;

public interface OrderDetailService {
    //添加订单详情
    void addDetails(List<OrderDetail> details);
    /**
     * 后台
     */
    List<OrderDetail> findByOrder(String oid);
}
