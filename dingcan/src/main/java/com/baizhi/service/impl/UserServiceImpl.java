package com.baizhi.service.impl;

import com.baizhi.dao.UserMapper;
import com.baizhi.entity.Business;
import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import com.baizhi.utils.MD5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.*;

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
        String salt = "";

        if (users.size() == 0){        //账号不存在或申请还未通过
            map.put("success",0);
            map.put("msg","该账号不存在");
        }else{
            User userdb = users.get(0);
            if(userdb.getStatus() == 0){
                map.put("success",0);
                map.put("msg","该账号被冻结");
            }else {
                salt = users.get(0).getSalt();
                user.setPassword(MD5Utils.getPassword(password+salt));
                List<User> users1 = userMapper.select(user);
                if(users1.size() == 0){    //密码错误
                    map.put("success",0);
                    map.put("msg","密码错误！");
                }else{
                    //登录成功
                    map.put("success",1);
                    session.setAttribute("userId",users1.get(0).getId());
                    session.setAttribute("username",users1.get(0).getUsername());
                }
            }
        }
        return map;
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public User findById(String id) {
        User user = new User();
        user.setId(id);
        List<User> users = userMapper.select(user);
        return users.get(0);
    }

    @Override
    public void update(User user) {
        userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public void register(User user) {
        String salt = MD5Utils.getSalt();

        user.setId(UUID.randomUUID().toString());
        user.setRegister(new Date());
        user.setSalt(salt);
        user.setPassword(MD5Utils.getPassword(user.getPassword()+salt));
        user.setImgUrl("userImg/header.png");
        user.setStatus(1);
        userMapper.insert(user);
    }

    @Override
    public Map<String,Object> changePass(String oldPass, String newPass, String uid) {
        Map<String,Object> map = new HashMap<>();
        User user = userMapper.selectByPrimaryKey(uid);
        System.out.println(user+"====");
        System.out.println(user.getPassword());
        System.out.println(oldPass);
        oldPass = MD5Utils.getPassword(oldPass+user.getSalt());

        if(user.getPassword().equals(oldPass)){
            user.setPassword(MD5Utils.getPassword(newPass+user.getSalt()));
            userMapper.updateByPrimaryKeySelective(user);

            map.put("msg","修改成功~~");
            map.put("success",true);
        }else{
            map.put("msg","原密码错误！");
            map.put("success",false);
        }
        return map;
    }

    @Override
    public List<User> findAll() {
        List<User> users = userMapper.selectAll();
        return users;
    }

    @Override
    public void changeStatus(String id,Integer status) {
        User user = new User();
        user.setId(id);
        if(status == 1){
            user.setStatus(0);
        }else{
            user.setStatus(1);
        }
        userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public void forgetPass(String phone, String newPass) {
        User user = new User();
        user.setPhone(phone);
        User user1 = userMapper.select(user).get(0);
        user1.setPassword(MD5Utils.getPassword(newPass+user1.getSalt()));
        userMapper.updateByPrimaryKeySelective(user1);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Integer findByUsername(String username) {
        User user = new User();
        user.setUsername(username);
        List<User> select = userMapper.select(user);
        if (select.size() == 0){
            return 0;
        }else {
            return 1;
        }
    }

    @Override
    public Integer findByPhone(String phone) {
        User user = new User();
        user.setPhone(phone);
        List<User> select = userMapper.select(user);
        if (select.size() == 0){
            return 0;
        }else {
            return 1;
        }
    }
}
