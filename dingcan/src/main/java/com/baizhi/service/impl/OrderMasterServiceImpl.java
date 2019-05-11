package com.baizhi.service.impl;

import com.baizhi.dao.OrderMasterMapper;
import com.baizhi.entity.OrderMaster;
import com.baizhi.entity.PageBean;
import com.baizhi.service.OrderMasterService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.annotation.Order;

import java.util.List;

@Service
@Transactional
public class OrderMasterServiceImpl implements OrderMasterService {

    @Autowired
    private OrderMasterMapper masterMapper;

    @Override
    public void add(OrderMaster orderMaster) {
        masterMapper.insert(orderMaster);
    }

    @Override
    public PageBean findByPage(Integer pageNow,Integer pageCount) {
        PageHelper.startPage(pageNow,pageCount);
        List<OrderMaster> orderMasters = masterMapper.findAll();
        PageInfo pageInfo = new PageInfo(orderMasters);
        PageBean pageBean = new PageBean(pageNow, pageInfo.getTotal(), pageInfo.getPages(), pageInfo.getList());
        return pageBean;
    }
}
