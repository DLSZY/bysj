package com.baizhi;

import com.baizhi.dao.*;
import com.baizhi.entity.*;
import com.baizhi.service.AddressService;
import com.baizhi.service.CartService;
import com.baizhi.service.CateInStoreService;
import com.baizhi.utils.MD5Utils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import tk.mybatis.mapper.annotation.Order;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

@SpringBootTest(classes = Application.class)
@RunWith(SpringRunner.class)
public class Test1 {
    @Autowired
    private BusinessMapper businessMapper;
    @Autowired
    private GoodsCateinstoreMapper goodsCateinstoreMapper;
    @Autowired
    private CartService cartService;
    @Autowired
    private ShopCartMapper cartMapper;
    @Autowired
    private OrderDetailMapper detailMapper;
    @Autowired
    private  OrderMasterMapper masterMapper;

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
    @Test
    public void test3(){
        List<Cart> cartByUser = cartService.findCartByUser("1");
        for (Cart cart : cartByUser) {
            System.out.println(cart);
        }
    }
    @Test
    public void test4(){
        List<ShopCart> byUser = cartMapper.findByUser("1");
        for (ShopCart shopCart : byUser) {
            System.out.println(shopCart);
        }
    }
    @Test
    public void test5(){
       /* OrderDetail detail1 = new OrderDetail("1","123","456",1);
        OrderDetail detail2 = new OrderDetail("2","123","345",3);
        List<OrderDetail> orderDetails = new ArrayList<>();
        orderDetails.add(detail1);
        orderDetails.add(detail2);
        detailMapper.addDetails(orderDetails);*/
    }
    @Test
    public void test6(){
        String password = MD5Utils.getPassword("123123" + "luffy107");
        System.out.println(password);
    }
    @Test
    public void test7(){
        List<OrderMaster> all = masterMapper.findAll();
        System.out.println(all);
    }

}
