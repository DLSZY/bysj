package com.baizhi.service;

import com.baizhi.entity.Reduce;

import java.util.List;

public interface ReduceService {
    void add(Reduce reduce,String businessId);

    List<Reduce> findAll(String businessId);

    void delete(String id);

    /**
     * 用户
     */
    //显示商家时，显示满减信息
    List<Reduce> findByBusiness(String bid);
}
