package com.baizhi.controller;

import com.baizhi.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Map;

@RestController
@RequestMapping("admin")
public class AdminController {
    @Autowired
    private AdminService adminService;

    @RequestMapping("login")
    public Map login(String username, String password, HttpSession session){
        Map<String, Object> map = adminService.login(username, password,session);
        return map;
    }
    @RequestMapping("exit")
    public void exit(HttpSession session){
        session.removeAttribute("adminUsername");
        session.removeAttribute("adminId");

    }
}
