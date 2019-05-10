package com.baizhi.service.impl;

import com.baizhi.dao.UserMapper;
import com.baizhi.entity.Business;
import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Map<String, Object> login(String username, String password, HttpSession session) {
        Map<String,Object> map = new HashMap<>();
        //根据用户名查询
        User user = new User();
        user.setUsername(username);
        List<User> users = userMapper.select(user);

        if (users.size() == 0){        //账号不存在或申请还未通过
            map.put("success",0);
            map.put("msg","该账号不存在");
        }else{
            user.setPassword(password);
            List<User> users1 = userMapper.select(user);
            if(users1.size() == 0){    //密码错误
                map.put("success",0);
                map.put("msg","密码错误！");
            }else{
                //登录成功
                map.put("success",1);
                session.setAttribute("userId",users1.get(0).getId());
                session.setAttribute("userUsername",users1.get(0).getUsername());
            }
        }
        return map;
    }
}
