package com.baizhi.controller;

import com.baizhi.entity.GoodsCateinstore;
import com.baizhi.entity.PageBean;
import com.baizhi.service.CateInStoreService;
import org.apache.http.client.methods.HttpOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
@RequestMapping("cateInStore")
public class CateInStoreController {

    @Autowired
    private CateInStoreService cateInStoreService;

    @RequestMapping("add")
    public void add(String name, HttpSession session){
        String businessId = (String) session.getAttribute("businessId");
        cateInStoreService.addCate(name,businessId);
    }
    @RequestMapping("findAll")
    public PageBean findAll(Integer page, Integer rows, HttpSession session){
        String businessId = (String) session.getAttribute("businessId");
        PageBean allCate = cateInStoreService.findAllCate(page, rows,businessId);
        return allCate;
    }
    @RequestMapping("delete")
    public void delete(String id){
        cateInStoreService.delete(id);
    }


    //用户
    @RequestMapping("findByBusiness")
    public List<GoodsCateinstore> findByBusiness(String bid){
        return cateInStoreService.findByBusiness(bid);
    }

}
