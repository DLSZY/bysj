package com.baizhi.service.impl;

import com.baizhi.dao.GoodsMapper;
import com.baizhi.entity.Goods;
import com.baizhi.entity.PageBean;
import com.baizhi.service.GoodsService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.entity.Example;

import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class GoodsServiceImpl implements GoodsService {
    @Autowired
    private GoodsMapper goodsMapper;

    @Override
    public List<Goods> findByCateInStore(String csid) {
        Goods goods = new Goods();
        goods.setCateinstoreId(csid);
        List<Goods> list = goodsMapper.select(goods);
        return list;
    }

    @Override
    public void add(Goods goods) {
        goods.setId(UUID.randomUUID().toString());
        goods.setSaleCount(0);
        goodsMapper.insert(goods);
    }

    @Override
    public void update(Goods goods) {
        goodsMapper.updateByPrimaryKeySelective(goods);
    }

    @Override
    public PageBean findFood(Integer page, Integer rows,String businessId) {
        PageHelper.startPage(page, rows);
        Example example = new Example(Goods.class);
        example.createCriteria().andEqualTo("businessId", businessId);
        List<Goods> goods = goodsMapper.findGood(businessId);
        PageInfo pageInfo = new PageInfo(goods);
        PageBean pageBean = new PageBean(page, pageInfo.getTotal(), pageInfo.getPages(), pageInfo.getList());
        return pageBean;
    }

    @Override
    public Goods findOne(String id) {
        Goods one = goodsMapper.findOne(id);
        return one;
    }

    @Override
    public void delete(String id) {
        goodsMapper.deleteByPrimaryKey(id);
    }

    @Override
    public PageBean findAll(Integer page, Integer rows) {
        PageHelper.startPage(page, rows);
        List<Goods> goods = goodsMapper.findAll();
        PageInfo pageInfo = new PageInfo(goods);
        PageBean pageBean = new PageBean(page, pageInfo.getTotal(), pageInfo.getPages(), pageInfo.getList());
        return pageBean;
    }

}
