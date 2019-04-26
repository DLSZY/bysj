package com.baizhi.service;

import com.baizhi.entity.Reduce;

import java.util.List;

public interface ReduceService {
    void add(Reduce reduce);

    List<Reduce> findAll();

    void delete(String id);
}
