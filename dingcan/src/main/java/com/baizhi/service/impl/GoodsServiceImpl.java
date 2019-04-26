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
    public PageBean findFood(Integer page,Integer rows) {
        PageHelper.startPage(page,rows);
        Example example = new Example(Goods.class);
        String businessId = "1";    //从session获取
        example.createCriteria().andEqualTo("businessId",businessId);
        List<Goods> goods = goodsMapper.findGood(businessId);
        PageInfo pageInfo = new PageInfo(goods);
        PageBean pageBean = new PageBean(page,pageInfo.getTotal(),pageInfo.getPages(),pageInfo.getList());
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
}
