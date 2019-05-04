package com.baizhi.service.impl;

import com.baizhi.dao.GoodsCateinstoreMapper;
import com.baizhi.dao.GoodsMapper;
import com.baizhi.entity.Goods;
import com.baizhi.entity.GoodsCateinstore;
import com.baizhi.entity.PageBean;
import com.baizhi.service.CateInStoreService;
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
public class CateInStoreServiceImpl implements CateInStoreService {

    @Autowired
    private GoodsCateinstoreMapper cateinstoreMapper;
    @Autowired
    private GoodsMapper goodsMapper;

    @Override
    public void addCate(String name,String businessId) {
        GoodsCateinstore cateinstore = new GoodsCateinstore();
        cateinstore.setId(UUID.randomUUID().toString());
        cateinstore.setName(name);
        cateinstore.setBusinessId(businessId); //在session中获取本店id

        cateinstoreMapper.insert(cateinstore);
    }

    @Override
    public PageBean findAllCate(Integer pageNow,Integer pageCount,String businessId) {
        PageHelper.startPage(pageNow,pageCount);
        Example example = new Example(GoodsCateinstore.class);
        example.createCriteria().andEqualTo("businessId",businessId);
        List<GoodsCateinstore> cates = cateinstoreMapper.selectByExample(example);
        PageInfo pageInfo = new PageInfo(cates);
        PageBean pageBean = new PageBean(pageNow,pageInfo.getTotal(),pageInfo.getPages(),pageInfo.getList());
        return pageBean;
    }

    @Override
    public List<GoodsCateinstore> findAll(String businessId) {
        Example example = new Example(GoodsCateinstore.class);
        example.createCriteria().andEqualTo("businessId",businessId);
        List<GoodsCateinstore> cates = cateinstoreMapper.selectByExample(example);
        return cates;
    }

    @Override
    public void delete(String id) {
        cateinstoreMapper.deleteByPrimaryKey(id);
        Example example = new Example(Goods.class);
        example.createCriteria().andEqualTo("cateinstoreId",id);
        goodsMapper.deleteByExample(example);
    }
}
