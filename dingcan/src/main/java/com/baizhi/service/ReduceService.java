package com.baizhi.service;

import com.baizhi.entity.Reduce;

import java.util.List;

public interface ReduceService {
    void add(Reduce reduce,String businessId);

    List<Reduce> findAll(String businessId);

    void delete(String id);
}
