package com.baizhi.service.impl;

import com.baizhi.dao.AdminMapper;
import com.baizhi.entity.Admin;
import com.baizhi.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminMapper adminMapper;

    @Override
    public Map<String, Object> login(String username, String password, HttpSession session) {
        Admin admin = new Admin();
        admin.setUsername(username);
        List<Admin> admins = adminMapper.select(admin);
        Map<String,Object> map = new HashMap<>();
        if(admins.size() != 0){
            Admin selectAdmin = admins.get(0);
            if(selectAdmin.getPassword().equals(password)){
                map.put("isLogin",true);
                session.setAttribute("adminId",selectAdmin.getId());
                session.setAttribute("adminUsername",username);
            }else {
                map.put("isLogin",false);
                map.put("msg","密码错误!");
            }
        }else {
            map.put("isLogin",false);
            map.put("msg","账号不存在!");
        }
        return map;
    }
}
