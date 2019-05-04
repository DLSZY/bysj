package com.baizhi.service.impl;

import com.baizhi.dao.GoodsCateMapper;
import com.baizhi.entity.GoodsCate;
import com.baizhi.entity.PageBean;
import com.baizhi.service.CategoryService;
import com.github.pagehelper.Page;
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
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private GoodsCateMapper cateMapper;

    @Override
    public void add(GoodsCate cate) {
        cate.setId(UUID.randomUUID().toString());
        cateMapper.insert(cate);
    }

    @Override
    public PageBean select(Integer level,Integer page,Integer rows) {
        PageHelper.startPage(page,rows);
        Example example = new Example(GoodsCate.class);
        example.createCriteria().andEqualTo("level",level);
        List<GoodsCate> cates = cateMapper.selectByExample(example);
        PageInfo pageInfo = new PageInfo(cates);

        PageBean pageBean = new PageBean(page,pageInfo.getTotal(),pageInfo.getPages(),pageInfo.getList());
        return pageBean;

    }

    @Override
    public List<GoodsCate> findCateByLevel(Integer level) {
        Example example = new Example(GoodsCate.class);
        example.createCriteria().andEqualTo("level",level);
        List<GoodsCate> cates = cateMapper.selectByExample(example);
        return cates;
    }

    @Override
    public void deleteSecond(String id) {
        cateMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void deleteFirst(String id) {
        //删除以及类别
        cateMapper.deleteByPrimaryKey(id);
        //删除以及类别下的二级类别
        Example example = new Example(GoodsCate.class);
        example.createCriteria().andEqualTo("parentId",id);
        cateMapper.deleteByExample(example);
    }

    @Override
    public List<GoodsCate> selectByFistName(String firstName) {
        Example example = new Example(GoodsCate.class);
        example.createCriteria().andEqualTo("parentName",firstName);
        List<GoodsCate> cates = cateMapper.selectByExample(example);
        return cates;
    }
}









