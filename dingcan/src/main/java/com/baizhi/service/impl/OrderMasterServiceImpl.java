package com.baizhi.service.impl;

import com.baizhi.dao.OrderMasterMapper;
import com.baizhi.entity.*;
import com.baizhi.service.BusinessService;
import com.baizhi.service.OrderDetailService;
import com.baizhi.service.OrderMasterService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.annotation.Order;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class OrderMasterServiceImpl implements OrderMasterService {

    @Autowired
    private OrderMasterMapper masterMapper;
    @Autowired
    private OrderDetailService detailService;
    @Autowired
    private BusinessService businessService;

    @Override
    public void add(OrderMaster orderMaster) {
        masterMapper.insert(orderMaster);
    }

    @Override
    public List<OrderMaster> findByUser(String uid) {
        OrderMaster orderMaster = new OrderMaster();
        orderMaster.setUserId(uid);
        orderMaster.setStatus(1);
        List<OrderMaster> masters = masterMapper.select(orderMaster);
        //查询每个订单下的订单项
        for (OrderMaster master : masters) {
            String masterId = master.getId();
            List<OrderDetail> byOrder = detailService.findByOrder(masterId);
            master.setOrderdetails(byOrder);

            Business business = businessService.findById(master.getBusinessId());
            master.setBusinessName(business.getName());

        }
        return masters;
    }

    @Override
    public void del(String oid) {
        OrderMaster orderMaster = new OrderMaster();
        orderMaster.setId(oid);
        orderMaster.setStatus(0);
        masterMapper.updateByPrimaryKeySelective(orderMaster);
    }

    @Override
    public PageBean findByPage(Integer pageNow,Integer pageCount,String bid) {
        PageHelper.startPage(pageNow,pageCount);
        List<OrderMaster> orderMasters = new ArrayList<>();
        if(StringUtils.isEmpty(bid)){
            orderMasters = masterMapper.findAll();
        }else{
            orderMasters = masterMapper.findByBusiness(bid);
        }

        PageInfo pageInfo = new PageInfo(orderMasters);
        PageBean pageBean = new PageBean(pageNow, pageInfo.getTotal(), pageInfo.getPages(), pageInfo.getList());
        return pageBean;
    }

    @Override
    public OrderMaster findById(String oid) {
        return masterMapper.selectByPrimaryKey(oid);
    }
}
