package com.baizhi.service.impl;

import com.baizhi.dao.OrderDetailMapper;
import com.baizhi.entity.OrderDetail;
import com.baizhi.entity.OrderMaster;
import com.baizhi.service.OrderDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class OrderDetailsServiceImpl implements OrderDetailService {

    @Autowired
    private OrderDetailMapper detailMapper;

    @Override
    public void addDetails(List<OrderDetail> details) {
        detailMapper.addDetails(details);
    }

    @Override
    public List<OrderDetail> findByOrder(String oid) {
        List<OrderDetail> details = detailMapper.findByOrder(oid);
        return details;
    }

}
