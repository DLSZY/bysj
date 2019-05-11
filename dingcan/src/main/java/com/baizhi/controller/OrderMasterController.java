package com.baizhi.controller;

import com.baizhi.entity.OrderDetail;
import com.baizhi.entity.OrderMaster;
import com.baizhi.entity.PageBean;
import com.baizhi.entity.ShopCart;
import com.baizhi.service.CartService;
import com.baizhi.service.OrderDetailService;
import com.baizhi.service.OrderMasterService;
import lombok.experimental.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import tk.mybatis.mapper.annotation.Order;

import javax.servlet.http.HttpSession;
import java.util.*;

@RequestMapping("orderMaster")
@RestController
public class OrderMasterController {

    @Autowired
    private CartService cartService;
    @Autowired
    private OrderMasterService masterService;
    @Autowired
    private OrderDetailService detailService;

    /**
     * 管理员
     */
    @RequestMapping("findByPage")
    public PageBean findByPage(Integer page,Integer rows){
        PageBean byPage = masterService.findByPage(page, rows);
        return byPage;
    }
    @RequestMapping("findDetail")
    public Map<String,Object> findDetail(String oid){
        Map<String,Object> map = new HashMap<>();
        List<OrderDetail> details = detailService.findByOrder(oid);
        map.put("details",details);



        return map;
    }

    /**
     * 用户
     */
    @RequestMapping("add")
    public void add(String addressId, String userRemarks, HttpSession session,String bid){
        //创建订单
        OrderMaster orderMaster = new OrderMaster();
        orderMaster.setAddressId(addressId);
        orderMaster.setCreateDate(new Date());
        Double allPrice = (Double) session.getAttribute("allPrice");
        orderMaster.setOrderAmount(allPrice);
        orderMaster.setOrderNum(new Date().getTime()+"");
        String oid = UUID.randomUUID().toString();
        orderMaster.setId(oid);
        orderMaster.setPayStatus(1);
        orderMaster.setStatus(1);
        orderMaster.setUserRemarks(userRemarks);
        String userId = (String) session.getAttribute("userId");
        orderMaster.setUserId(userId);

        masterService.add(orderMaster);

        //创建订单项
        List<ShopCart> carts = cartService.findByUserAndBusid(userId, bid);
        List<OrderDetail> details = new ArrayList<>();
        for (ShopCart cart : carts) {
            OrderDetail detail = new OrderDetail();
            detail.setOrderId(oid);
            detail.setGoodsCount(cart.getGoodsCount());
            detail.setGoodsId(cart.getGoodsId());
            detail.setId(UUID.randomUUID().toString());
            details.add(detail);
        }
        detailService.addDetails(details);

        //订单完成，删除购物车
        cartService.delete(userId,bid);
    }
}
