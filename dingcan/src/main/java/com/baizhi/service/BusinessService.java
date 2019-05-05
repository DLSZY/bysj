package com.baizhi.service;

import com.baizhi.entity.Business;
import com.baizhi.entity.BusinessRefuseReason;
import com.baizhi.entity.PageBean;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

public interface BusinessService {

    /**
     * 用户
     */
    //查询所有正常商家
    List<Business> findAllNormal();
    //根据一级类别查询商家
    List<Business> findByFirst(String cateName);
    //根据二级类别查询商家
    List<Business> findBySecond(String cateName);
    //根据商家查询
    List<Business> findByBusiness(String item);
    //根据食品或类别查询
    List<Business> findByGoods(String item);

    /**
    *商家
    */
    //注册
    void register (Business business);
    //登录
    Map<String,Object> login(String username, String password, HttpSession session);
    //修改密码使判断账号是否存在
    Integer checkExist(String username);
    //修改谜面时判断用户名和手机号是否匹配
    Integer checkUserPhone(String username,String phone);
    //修改密码
    void changePass(String username,String newPassword);
    //查询本店信息
    Business findInfo(String id);
    //修改本店信息
    void changeInfo(Business business);



    /**
    * 管理员
    */
    //查询不同状态的商家（申请，通过申请）
    PageBean findBusinessByRegister(Integer pageNow,Integer showCount,Integer registerStatus);
    //通过商家的申请
    void passRegister(String id);
    //拒绝商家申请
    void refuseRegister(BusinessRefuseReason businessRefuseReason);
    //从表中删除已经拒绝的商家
    void hide(String id);
    //修改商家状态
    void changeStatus(Business business);


}
