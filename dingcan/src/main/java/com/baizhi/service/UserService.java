package com.baizhi.service;

import com.baizhi.entity.User;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

public interface UserService {
    /**
     * 用户
     */
    //登录
    Map<String,Object> login(String username, String password, HttpSession session);
    //根据id查询（显示信息）
    User findById(String id);
    //修改用户信息（修改头像）
    void update(User user);
    //注册
    void register(User user);

    /**
     * 后台
     */
    //查询所有用户
    List<User> findAll();
    //修改用户状态
    void changeStatus(String id,Integer status);

}
