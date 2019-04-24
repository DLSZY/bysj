package com.baizhi.service.impl;

import com.baizhi.dao.BusinessMapper;
import com.baizhi.dao.BusinessRefuseResonMapper;
import com.baizhi.entity.Business;
import com.baizhi.entity.BusinessRefuseReason;
import com.baizhi.service.BusinessService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.entity.Example;

import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class BusinessServiceImpl implements BusinessService {

    @Autowired
    private BusinessMapper businessMapper;
    @Autowired
    private BusinessRefuseResonMapper businessRefuseResonMapper;

    @Override
    public void register(Business business) {
        business.setId(UUID.randomUUID().toString());
        business.setRegisterTime(new Date());
        business.setRegisterStatus(0);
        business.setStartPrice(0.0);
        business.setDistributionFee(0.0);
        System.out.println(business);
        businessMapper.insertSelective(business);
    }

    @Override
    public List<Business> findBusinessByRegister(Integer registerStatus) {
        Example example = new Example(Business.class);
        example.createCriteria().andEqualTo("registerStatus",registerStatus);
        List<Business> businesses = businessMapper.selectByExample(example);
        return businesses;
    }

    @Override
    public void passRegister(String id) {
        Business business = new Business();
        business.setId(id);
        business.setRegisterStatus(1);
        business.setStatus(1);
        businessMapper.updateByPrimaryKeySelective(business);
    }

    @Override
    public void refuseRegister(BusinessRefuseReason businessRefuseReason) {
        businessRefuseReason.setId(UUID.randomUUID().toString());
        businessRefuseReason.setCreateDate(new Date());
        businessRefuseResonMapper.insertSelective(businessRefuseReason);
    }

    @Override
    public void hide(String id) {
        Business business = new Business();
        business.setId(id);
        business.setRegisterStatus(2);
        businessMapper.updateByPrimaryKeySelective(business);
    }

    @Override
    public void changeStatus(Business business) {
        Integer status = business.getStatus();
        status = status == 0 ? 1 : 0;
        business.setStatus(status);
        businessMapper.updateByPrimaryKeySelective(business);
    }

}
