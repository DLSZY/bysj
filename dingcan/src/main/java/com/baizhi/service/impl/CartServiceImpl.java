package com.baizhi.service.impl;

import com.baizhi.dao.ShopCartMapper;
import com.baizhi.entity.*;
import com.baizhi.service.BusinessService;
import com.baizhi.service.CartService;
import com.baizhi.service.ReduceService;
import lombok.experimental.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.entity.Example;

import java.util.*;

@Service
@Transactional
public class CartServiceImpl implements CartService {

    @Autowired
    ShopCartMapper cartMapper;
    @Autowired
    BusinessService businessService;
    @Autowired
    ReduceService reduceService;

    @Override
    public void add(ShopCart shopCart) {
        List<ShopCart> select1 = cartMapper.select(shopCart);
        if(select1.size() != 0){
            editCount(select1.get(0).getId(),"add");
        }else {
            shopCart.setId(UUID.randomUUID().toString());
            shopCart.setGoodsCount(1);
            cartMapper.insert(shopCart);
        }
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<Cart> findCartByUser(String uid) {
        List<ShopCart> carts = cartMapper.findByUser(uid);
        Map <String,List> map = new HashMap<>();
        for (ShopCart cart : carts) {
            if(!map.containsKey(cart.getBusinessId())){
                List list = new ArrayList();
                list.add(cart);
                map.put(cart.getBusinessId(),list);
            }else {
                map.get(cart.getBusinessId()).add(cart);
            }
        }

        List<Cart> carts1 = new ArrayList<>();
         Set<Map.Entry<String, List>> entries = map.entrySet();
        for (Map.Entry<String, List> entry : entries) {
            Cart cart = new Cart();
            String bid = entry.getKey();
            Business business = businessService.findById(bid);
            List<Reduce> reduces = reduceService.findByBusiness(bid);
            cart.setBusinessId(bid);
            cart.setItems(entry.getValue());
            cart.setBusinessName(businessService.findById(entry.getKey()).getName());
            cart.setStartPrice(business.getStartPrice());
            cart.setDistributeFee(business.getDistributionFee());
            cart.setReduces(reduces);

            carts1.add(cart);
        }
        return carts1;
    }

    @Override
    public List<ShopCart> findByUserAndBusid(String uid, String bid) {
        ShopCart shopCart = new ShopCart();
        shopCart.setUserId(uid);
        shopCart.setBusinessId(bid);
        List<ShopCart> shopCarts = cartMapper.findByUserAndBusiness(uid,bid);
        System.out.println(shopCarts);
        return shopCarts;
    }

    @Override
    public void editCount(String cid,String option) {
        ShopCart shopCart = new ShopCart();
        shopCart.setId(cid);
        List<ShopCart> select = cartMapper.select(shopCart);
        ShopCart selectCart = select.get(0);
        Integer count = selectCart.getGoodsCount();
        if(option.equals("add")){                   //添加操作
            selectCart.setGoodsCount(count+1);
            cartMapper.updateByPrimaryKey(selectCart);
        }else {                                     //减少操作
            if(count >1 ){               //判断此时商品数量是否大于1
                selectCart.setGoodsCount(count-1);
                cartMapper.updateByPrimaryKey(selectCart);
            }else{
                cartMapper.deleteByPrimaryKey(cid);
            }
        }
    }

    @Override
    public void delete(String uid, String bid) {
        ShopCart shopCart = new ShopCart();
        shopCart.setUserId(uid);
        shopCart.setBusinessId(bid);
        cartMapper.delete(shopCart);
    }

}
