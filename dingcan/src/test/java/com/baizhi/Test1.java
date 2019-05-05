package com.baizhi;

import com.baizhi.dao.BusinessMapper;
import com.baizhi.dao.GoodsMapper;
import com.baizhi.entity.Business;
import com.baizhi.entity.City;
import com.baizhi.entity.Goods;
import com.baizhi.entity.Province;
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

    @Test
    public void test1(){
        List<Business> bySearch = businessMapper.findByGoods("寿司");
        for (Business search : bySearch) {
            System.out.println(search.getName());
            System.out.println(search.getGoodss());
            System.out.println();
        }
    }

}
