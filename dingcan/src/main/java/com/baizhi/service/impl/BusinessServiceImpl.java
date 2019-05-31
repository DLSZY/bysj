package com.baizhi.service.impl;

import com.baizhi.dao.BusinessMapper;
import com.baizhi.dao.BusinessRefuseResonMapper;
import com.baizhi.entity.Business;
import com.baizhi.entity.BusinessRefuseReason;
import com.baizhi.entity.PageBean;
import com.baizhi.service.BusinessService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.entity.Example;

import javax.servlet.http.HttpSession;
import java.util.*;

@Service
@Transactional
public class BusinessServiceImpl implements BusinessService {

    @Autowired
    private BusinessMapper businessMapper;
    @Autowired
    private BusinessRefuseResonMapper businessRefuseResonMapper;

    @Override
    public List<Business> findAllNormal() {
        Business business = new Business();
        business.setStatus(1);
        List<Business> select = businessMapper.select(business);
        return select;
    }

    @Override
    public List<Business> findByFirst(String cateName) {
        return businessMapper.findByFirst(cateName);
    }

    @Override
    public List<Business> findBySecond(String cateName) {
        return businessMapper.findBySecond(cateName);
    }

    @Override
    public List<Business> findByBusiness(String item) {
        return businessMapper.findByBusiness(item);
    }
    @Override
    public List<Business> findByGoods(String item) {
        return businessMapper.findByGoods(item);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Business findById(String id) {
        return businessMapper.selectByPrimaryKey(id);
    }

    @Override
    public void register(Business business) {
        business.setId(UUID.randomUUID().toString());
        business.setRegisterTime(new Date());
        business.setRegisterStatus(0);
        business.setStartPrice(0.0);
        business.setDistributionFee(0.0);
        System.out.println(business);
        businessMapper.insertSelective(business);
    }

    @Override
    public Map<String,Object> login(String username, String password, HttpSession session) {
        Map<String,Object> map = new HashMap<>();
        //根据用户名查询
        Business business = new Business();
        business.setUsername(username);
        List<Business> businesses = businessMapper.select(business);

        if (businesses.size() == 0 || businesses.get(0).getRegisterStatus() != 1){        //账号不存在或申请还未通过
            map.put("success",0);
            map.put("msg","该账号不存在");
        }else{
            business.setPassword(password);
            List<Business> businesses1 = businessMapper.select(business);
            if(businesses1.size() == 0){    //密码错误
                map.put("success",0);
                map.put("msg","密码错误！");
            }else{
                if(businesses1.get(0).getStatus() == 0){    //被冻结
                    map.put("success",0);
                    map.put("msg","该账号被冻结！");
                }else{
                    //登录成功
                    map.put("success",1);
                    session.setAttribute("businessId",businesses1.get(0).getId());
                    session.setAttribute("businessUsername",businesses1.get(0).getUsername());
                }
            }
        }
        return map;
    }

    @Override
    public Integer checkExist(String username) {
        Example example = new Example(Business.class);
        //查找账号，注册状态
        example.createCriteria().andEqualTo("username",username).andEqualTo("registerStatus",1);
        List<Business> businesses = businessMapper.selectByExample(example);
        if(businesses.size() == 0){
            return 0;   //账号不存在或申请未通过
        }
        Example example1 = new Example(Business.class);
        example1.createCriteria().andEqualTo("username",username).andEqualTo("status",1);
        businesses = businessMapper.selectByExample(example1);
        if(businesses.size() == 0){
            return 1;   //账号冻结
        }else {
            return 2;   //账号正常
        }
    }

    @Override
    public Integer checkUserPhone(String username, String phone) {
        Example example = new Example(Business.class);
        example.createCriteria().andEqualTo("username",username).andEqualTo("phone",phone);
        List<Business> businesses = businessMapper.selectByExample(example);
        return businesses.size();
    }

    @Override
    public void changePass(String username, String newPassword) {
        Business business = new Business();
        business.setPassword(newPassword);

        Example example = new Example(Business.class);
        example.createCriteria().andEqualTo("username",username);
        businessMapper.updateByExampleSelective(business,example);
    }

    @Override
    public Business findInfo(String id) {
        Business business = businessMapper.selectByPrimaryKey(id);
        return business;
    }

    @Override
    public void changeInfo(Business business) {
        System.out.println(business);
        businessMapper.updateByPrimaryKeySelective(business);
    }

    @Override
    public Integer findByName(String name) {
        Business business = new Business();
        business.setName(name);
        List<Business> select = businessMapper.select(business);
        if (select.size() == 0){
            return 0;
        }else {
            return 1;
        }
    }

    @Override
    public Integer findByPhone(String phone) {
        Business business = new Business();
        business.setPhone(phone);
        List<Business> select = businessMapper.select(business);
        if (select.size() == 0){
            return 1;
        }else {
            return 0;
        }
    }

    @Override
    public PageBean findBusinessByRegister(Integer pageNow,Integer showCount,Integer registerStatus) {
        PageHelper.startPage(pageNow,showCount);
        Example example = new Example(Business.class);
        example.createCriteria().andEqualTo("registerStatus",registerStatus);
        List<Business> businesses = businessMapper.selectByExample(example);
        PageInfo pageInfo = new PageInfo(businesses);
        PageBean pageBean = new PageBean(pageNow,pageInfo.getTotal(),pageInfo.getPages(),pageInfo.getList());
        return pageBean;
    }

    @Override
    public void passRegister(String id) {
        Business business = new Business();
        business.setId(id);
        business.setRegisterStatus(1);
        business.setStatus(1);
        businessMapper.updateByPrimaryKeySelective(business);
    }

    @Override
    public void refuseRegister(BusinessRefuseReason businessRefuseReason) {
        businessRefuseReason.setId(UUID.randomUUID().toString());
        businessRefuseReason.setCreateDate(new Date());
        businessRefuseResonMapper.insertSelective(businessRefuseReason);
    }

    @Override
    public void hide(String id) {
        Business business = new Business();
        business.setId(id);
        business.setRegisterStatus(2);
        businessMapper.updateByPrimaryKeySelective(business);
    }

    @Override
    public void changeStatus(Business business) {
        Integer status = business.getStatus();
        status = status == 0 ? 1 : 0;
        business.setStatus(status);
        businessMapper.updateByPrimaryKeySelective(business);
    }

    @Override
    public Business findByOrder(String oid) {
        return businessMapper.findByOrder(oid);
    }

}
