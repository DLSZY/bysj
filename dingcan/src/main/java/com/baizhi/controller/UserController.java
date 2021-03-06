package com.baizhi.controller;

import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import com.baizhi.utils.PhoneIdentify;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
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
    //个人中心修改密码
    @RequestMapping("changePass")
    public Map changePass(String oldPassword,String newPassword,HttpSession session){
        String userId = (String) session.getAttribute("userId");
        Map<String, Object> map = userService.changePass(oldPassword, newPassword, userId);
        return map;
    }

    /*修改密码时发送手机验证码*/
    @RequestMapping("sendPhoneCode")
    public Integer sendPhoneCode(String phone, HttpServletRequest request){
        Integer byPhone = userService.findByPhone(phone);
        if(byPhone == 1){
            //String code = PhoneIdentify.sendIdentify(phone);
            //System.out.println(code);
            //测试
            String code = "1234";
            request.getSession().setAttribute("user"+phone,code);                 //存入作用域
            request.getSession().setAttribute("userPhone",phone);
            return 1;
        }else {
            return 0;
        }
    }

    //修改密码时输入手机号判断验证码
    @RequestMapping("checkPhoneCode")
    public Integer checkUpdatePhoneCode(String phone,String phoneCode,HttpSession session){
        String code = (String) session.getAttribute("user"+phone);
        if (code == null){
            return 2;
        }else{
            if(code.equals(phoneCode)) {
                session.setAttribute("phoneCode",true);
                return 1;
            }
            else return 0;
        }
    }

    //忘记密码修改密码
    @RequestMapping("forgetPass")
    public void forgetPass(String password,HttpSession session){
        //获取手机号
        String phone = (String) session.getAttribute("userPhone");
        userService.forgetPass(phone,password);
    }
    //注册时判断用户名是否存在
    @RequestMapping("findByUsername")
    public Integer findByUsername(String username){
        Integer result = userService.findByUsername(username);
        return result;
    }
    //注册时判断手机号是否存在
    @RequestMapping("findByPhone")
    public Integer findByPhone(String phone){
        Integer result = userService.findByPhone(phone);
        return result;
    }

    //用户查看自己信息
    @RequestMapping("findInfo")
    public User findInfo(HttpSession session){
        String id = (String) session.getAttribute("userId");
        User user = userService.findById(id);
        return user;
    }
    //改变用户头像
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

    //添加（注册）
    @RequestMapping("register")
    public void register(User user){
        userService.register(user);
    }
    //判断是否登录或手机验证码是否正确
    @RequestMapping("judge")
    public String judge(){
        return "1";
    }
    @RequestMapping("clearPhoneCode")
    public void clearPhoneCode(HttpSession session){
        session.removeAttribute("phoneCode");
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
