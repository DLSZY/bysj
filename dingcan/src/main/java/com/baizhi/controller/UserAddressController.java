package com.baizhi.controller;

import com.baizhi.entity.Address;
import com.baizhi.service.UserAddressService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
@RequestMapping("userAddress")
public class UserAddressController {

    @Autowired
    private UserAddressService addressService;

    /**
     * 用户
     */
    @RequestMapping("del")
    public void del(String id){
        addressService.del(id);
    }

    @RequestMapping("edit")
    public void add(Address address, HttpSession session){
        String userId = (String) session.getAttribute("userId");
        address.setUserId(userId);
        if(StringUtils.isEmpty(address.getId())){
            addressService.add(address);
        }else {
            addressService.Update(address);
        }
    }

    @RequestMapping("selectByUser")
    public List<Address> findByUser(HttpSession session){
        String uid = (String) session.getAttribute("userId");
        List<Address> byUser = addressService.findByUser(uid);
        return byUser;
    }

    @RequestMapping("selectById")
    public Address findById(String id){
        Address address = addressService.findById(id);
        return address;
    }

    /**
     * 后台
     */
    @RequestMapping("findByOrder")
    public Address findByOrder(String oid){
        Address address = addressService.findByOrder(oid);
        System.out.println(address+"--");
        return address;
    }


}
