package com.baizhi.controller;

import com.baizhi.entity.*;
import com.baizhi.service.BusinessService;
import com.baizhi.service.CartService;
import com.baizhi.service.OrderDetailService;
import com.baizhi.service.OrderMasterService;
import lombok.experimental.var;
import org.apache.commons.lang3.StringUtils;
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
    @Autowired
    private BusinessService businessService;

    /**
     * 管理员
     */
    @RequestMapping("findByPage")
    public PageBean findByPage(Integer page,Integer rows){
        PageBean byPage = masterService.findByPage(page, rows,null);
        return byPage;
    }
    @RequestMapping("findDetail")
    public Map<String,Object> findDetail(String oid){
        Map<String,Object> map = new HashMap<>();
        //订单详情
        List<OrderDetail> details = detailService.findByOrder(oid);
        map.put("details",details);

        //查寻订单
        OrderMaster master = masterService.findById(oid);
        map.put("master",master);

        //查询订单商家
        Business business = businessService.findByOrder(oid);
        map.put("business",business);

        return map;
    }

    /**
     * 商家
     */
    @RequestMapping("findByBusinessPage")
    public PageBean findByBusinessPage(Integer page,Integer rows,HttpSession session){
        String bid = (String) session.getAttribute("businessId");
        PageBean byPage = masterService.findByPage(page, rows,bid);
        return byPage;
    }

    /**
     * 用户
     */

    //查询该用户所有订单
    @RequestMapping("findByUser")
    public List<OrderMaster> findByUser(HttpSession session){
        String uid = (String) session.getAttribute("userId");
        List<OrderMaster> masters = masterService.findByUser(uid);
        return masters;
    }
    //删除订单
    @RequestMapping("del")
    public void del(String oid){
        masterService.del(oid);
    }


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
        //orderMaster.setPayStatus(1);
        orderMaster.setStatus(1);
        orderMaster.setUserRemarks(userRemarks);
        orderMaster.setBusinessId(bid);
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
