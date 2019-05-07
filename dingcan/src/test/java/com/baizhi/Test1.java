package com.baizhi;

import com.baizhi.dao.BusinessMapper;
import com.baizhi.dao.GoodsCateinstoreMapper;
import com.baizhi.dao.GoodsMapper;
import com.baizhi.entity.*;
import com.baizhi.service.AddressService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@SpringBootTest(classes = Application.class)
@RunWith(SpringRunner.class)
public class Test1 {
    @Autowired
    private BusinessMapper businessMapper;
    @Autowired
    private GoodsCateinstoreMapper goodsCateinstoreMapper;

    @Test
    public void test1(){
        List<Business> bySearch = businessMapper.findByGoods("寿司");
        for (Business search : bySearch) {
            System.out.println(search.getName());
            System.out.println(search.getGoodss());
            System.out.println();
        }
    }

    @Test
    public void test2(){
        List cateinstores = goodsCateinstoreMapper.findByBusiness("1");
        for (Object cateinstore : cateinstores) {
            System.out.println(cateinstore);
            System.out.println();
        }
    }

}
