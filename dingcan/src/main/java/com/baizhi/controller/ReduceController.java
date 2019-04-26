package com.baizhi.controller;

import com.baizhi.entity.Reduce;
import com.baizhi.service.ReduceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("reduce")
public class ReduceController {
    @Autowired
    private ReduceService reduceService;

    @RequestMapping("add")
    public void add(Reduce reduce){
        reduceService.add(reduce);
    }

    @RequestMapping("findAll")
    public List findAll(){
        return reduceService.findAll();
    }

    @RequestMapping("delete")
    public void delete(String id){
        reduceService.delete(id);
    }
}
