package com.baizhi.service.impl;

import com.baizhi.dao.GoodsMapper;
import com.baizhi.entity.Goods;
import com.baizhi.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@Transactional
public class GoodsServiceImpl implements GoodsService {
    @Autowired
    private GoodsMapper goodsMapper;

    @Override
    public void add(Goods goods) {
        goods.setId(UUID.randomUUID().toString());
        goods.setSaleCount(0);
        goodsMapper.insert(goods);
    }
}
