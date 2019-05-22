package com.baizhi.controller;

import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;
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
        session.removeAttribute("username");
        session.removeAttribute("userId");
    }
    //修改密码
    @RequestMapping("changePass")
    public Map changePass(String oldPassword,String newPassword,HttpSession session){
        String userId = (String) session.getAttribute("userId");
        Map<String, Object> map = userService.changePass(oldPassword, newPassword, userId);
        return map;
    }
    @RequestMapping("findInfo")
    public User findInfo(HttpSession session){
        String id = (String) session.getAttribute("userId");
        User user = userService.findById(id);
        return user;
    }
    @RequestMapping("change")
    public void change(MultipartFile multipartFile, HttpSession session) throws IOException {
        String id = (String) session.getAttribute("userId");
        String realPath = session.getServletContext().getRealPath("/upload/userImg/");
        String extension = "."+FilenameUtils.getExtension(multipartFile.getOriginalFilename());
        String imgName = new Date().getTime()+"";
        File file = new File(realPath+"/"+imgName+extension);
        multipartFile.transferTo(file);

        User user = new User();
        user.setId(id);
        user.setImgUrl("userImg/"+imgName+extension);
        userService.update(user);
    }

    @RequestMapping("register")
    public void register(User user){
        userService.register(user);
    }

    /**
     * 后台
     */
    @RequestMapping("findAll")
    public List<User> findAll(){
        return userService.findAll();
    }
    //修改用户状态
    @RequestMapping("changeStatus")
    public void changeStatus(String id,Integer status){
        userService.changeStatus(id,status);
    }
}
