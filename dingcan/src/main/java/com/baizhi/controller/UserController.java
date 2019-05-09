package com.baizhi.controller;

import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Map;

@RestController
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService userService;

    /**
     * 用户
     */
    //登录
    @RequestMapping("login")
    public Map login(String username, String password, HttpSession session){
        Map<String, Object> login = userService.login(username, password, session);
        return login;
    }
    //退出
    @RequestMapping("exit")
    public void exit(HttpSession session){
        session.removeAttribute("userUsername");
        session.removeAttribute("userUserId");
    }
}
