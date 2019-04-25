package com.baizhi.controller;

import com.baizhi.entity.PageBean;
import com.baizhi.service.CateInStoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("cateInStore")
public class CateInStoreController {

    @Autowired
    private CateInStoreService cateInStoreService;

    @RequestMapping("add")
    public void add(String name){
        cateInStoreService.addCate(name);
    }
    @RequestMapping("findAll")
    public PageBean findAll(Integer page,Integer rows){
        PageBean allCate = cateInStoreService.findAllCate(page, rows);
        return allCate;
    }

}
