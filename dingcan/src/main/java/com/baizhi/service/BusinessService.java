package com.baizhi.service;

import com.baizhi.entity.Business;
import com.baizhi.entity.BusinessRefuseReason;

import java.util.List;

public interface BusinessService {
    //商家
    void register (Business business);

    /*
    * 管理员
    */
    //查询不同状态的商家（申请，通过申请）
    List<Business> findBusinessByRegister(Integer registerStatus);
    //通过商家的申请
    void passRegister(String id);
    //拒绝商家申请
    void refuseRegister(BusinessRefuseReason businessRefuseReason);
    //从表中删除已经拒绝的商家
    void hide(String id);
    //修改商家状态
    void changeStatus(Business business);


}
