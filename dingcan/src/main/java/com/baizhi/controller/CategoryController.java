package com.baizhi.controller;

import com.baizhi.entity.GoodsCate;
import com.baizhi.entity.PageBean;
import com.baizhi.service.CategoryService;
import com.github.pagehelper.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @RequestMapping("add")
    public void add(GoodsCate cate){
        categoryService.add(cate);
    }

    @RequestMapping("selectByLevelAndPage")
    public PageBean selectByLevelAndPage(Integer level, Integer page, Integer rows){
        return categoryService.select(level,page,rows);
    }

    @RequestMapping("selectByLevel")
    public List<GoodsCate> selectByLevel(Integer level){
        List<GoodsCate> cateByLevel = categoryService.findCateByLevel(level);
        return cateByLevel;
    }

    @RequestMapping("deleteSecond")
    public void deleteSecond(String id){
        categoryService.deleteSecond(id);
    }
    @RequestMapping("deleteFirst")
    public void deleteFirst(String id){
        categoryService.deleteFirst(id);
    }

}
