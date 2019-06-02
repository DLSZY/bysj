package com.baizhi.controller;

import com.baizhi.entity.Reduce;
import com.baizhi.service.ReduceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
@RequestMapping("reduce")
public class ReduceController {
    @Autowired
    private ReduceService reduceService;

    @RequestMapping("add")
    public void add(Reduce reduce, HttpSession session){
        String businessId = (String) session.getAttribute("businessId");
        reduceService.add(reduce,businessId);
    }

    @RequestMapping("findAll")
    public List findAll(HttpSession session){
        String businessId = (String) session.getAttribute("businessId");
        return reduceService.findAll(businessId);
    }

    @RequestMapping("delete")
    public void delete(String id){
        reduceService.delete(id);
    }


    /**
     * 用户
     */
    @RequestMapping("findByBusiness")
    public List<Reduce> findByBusiness(String bid){
        List<Reduce> reduceList = reduceService.findByBusiness(bid);
        return reduceList;
    }
}
