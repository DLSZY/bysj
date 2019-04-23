package com.baizhi.dao;

import com.baizhi.entity.OrderMaster;
import java.util.List;

public interface OrderMasterMapper {
    int deleteByPrimaryKey(String id);

    int insert(OrderMaster record);

    OrderMaster selectByPrimaryKey(String id);

    List<OrderMaster> selectAll();

    int updateByPrimaryKey(OrderMaster record);
}