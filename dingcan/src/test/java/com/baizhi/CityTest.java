package com.baizhi;

import com.baizhi.dao.GoodsMapper;
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
public class CityTest {

    @Autowired
    private AddressService addressService;
    @Autowired
    private GoodsMapper goodsMapper;

    @Test
    public void test(){
        List<Province> all = addressService.findProvince();
        for (Province province : all) {
            System.out.println(province);
        }
    }

    @Test
    public void test1(){
        List<City> all = addressService.findCity("130000");
        for (City province : all) {
            System.out.println(province);
        }
    }
    @Test
    public void test2(){
        List<Goods> good = goodsMapper.findGood("2");
        for (Goods goods : good) {
            System.out.println(goods);
        }
    }

}
