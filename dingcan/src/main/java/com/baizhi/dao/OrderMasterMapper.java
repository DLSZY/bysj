package com.baizhi.dao;

import com.baizhi.entity.Admin;
import com.baizhi.entity.OrderMaster;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface OrderMasterMapper extends Mapper<OrderMaster> {
    List<OrderMaster> findAll();
}