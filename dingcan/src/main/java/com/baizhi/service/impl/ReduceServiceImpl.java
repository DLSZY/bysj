package com.baizhi.service.impl;

import com.baizhi.dao.ReduceMapper;
import com.baizhi.entity.Reduce;
import com.baizhi.service.ReduceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.entity.Example;

import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class ReduceServiceImpl implements ReduceService {

    @Autowired
    private ReduceMapper reduceMapper;

    @Override
    public void add(Reduce reduce,String businessId) {
        reduce.setId(UUID.randomUUID().toString());
        reduce.setBusinessId(businessId);      //从session获取
        reduceMapper.insert(reduce);
    }

    @Override
    public List<Reduce> findAll(String businessId) {
        Reduce reduce = new Reduce();
        reduce.setBusinessId(businessId);
        return reduceMapper.select(reduce);
    }

    @Override
    public void delete(String id) {
        reduceMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<Reduce> findByBusiness(String bid) {
        /*Reduce reduce = new Reduce();
        reduce.setBusinessId(bid);
        List<Reduce> select = reduceMapper.select(reduce);*/

        Example example = new Example(Reduce.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andEqualTo("businessId",bid);
        example.setOrderByClause("achieve_money ASC");
        List<Reduce> reduces = reduceMapper.selectByExample(example);

        return reduces;
    }
}
