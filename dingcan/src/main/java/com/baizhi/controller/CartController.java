package com.baizhi.controller;

import com.baizhi.entity.Cart;
import com.baizhi.entity.ShopCart;
import com.baizhi.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@RequestMapping("cart")
@RestController
public class CartController {
    @Autowired
    private CartService cartService;

    //向购物车添加
    @RequestMapping("add")
    public void add(ShopCart shopCart, HttpSession session){
        System.out.println(shopCart+"---");
        String userId = (String) session.getAttribute("userId");
        shopCart.setUserId(userId);
        cartService.add(shopCart);
    }

    //查询当前用户的购物车
    @RequestMapping("findByUser")
    public List<Cart> findByUser(HttpSession session){
        String userId = (String) session.getAttribute("userId");
        List<Cart> cartList = cartService.findCartByUser(userId);
        return cartList;
    }
    //根据用户和商家查询购物车
    @RequestMapping("findByUserAndBuss")
    public List<ShopCart> findByUserAndBuss(HttpSession session,String bid){
        String userId = (String) session.getAttribute("userId");
        List<ShopCart> carts = cartService.findByUserAndBusid(userId, bid);
        return carts;
    }

    //添加购物车数量
    @RequestMapping("editCount")
    public void editCount(String cid,String option){
        cartService.editCount(cid,option);
    }

    //向session中存总费用
    @RequestMapping("allPrice")
    public void allPrice(Double allPrice,HttpSession session){
        session.removeAttribute("allPrice");
        session.setAttribute("allPrice",allPrice);
    }

}
