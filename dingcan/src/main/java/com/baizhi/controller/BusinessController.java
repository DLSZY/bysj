package com.baizhi.controller;

import com.baizhi.entity.Business;
import com.baizhi.entity.BusinessRefuseReason;
import com.baizhi.service.BusinessService;
import com.baizhi.utils.PhoneIdentify;
import com.google.code.kaptcha.impl.DefaultKaptcha;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("business")
public class BusinessController {

    @Autowired
    private BusinessService businessService;
    @Autowired
    private DefaultKaptcha defaultKaptcha;

    /*
    * 管理员操作
    * */

    //修改商家的状态
    @RequestMapping("changeStatus")
    public void changeStatue(Business business){
        businessService.changeStatus(business);
    }

    //查询申请的商家
    @RequestMapping("findRegister")
    public List<Business> findRegister(){
        List<Business> register = businessService.findBusinessByRegister(0);
        return register;
    }
    //查询已经通过申请的商家
    @RequestMapping("findBusiness")
    public List<Business> findBusiness(){
        List<Business> register = businessService.findBusinessByRegister(1);
        return register;
    }

    //通过商家的申请
    @RequestMapping("passRegister")
    public void passRegister(String id){
        businessService.passRegister(id);
    }
    //拒绝商家申请
    @RequestMapping("refuseRegister")
    public void refuseRegister(BusinessRefuseReason businessRefuseReason){
        businessService.refuseRegister(businessRefuseReason);
        businessService.hide(businessRefuseReason.getBusinessId());
    }


    /*
    * 商家操作
    * */
    //查询个人信息
    @RequestMapping("showInfo")
    public Business showInfo(){
        String id = "1";    //从session获取id
        Business info = businessService.findInfo(id);
        return info;
    }

    //修改个人信息
    @RequestMapping("changeInfo")
    public void changeInfo(Business business){
        businessService.changeInfo(business);
    }


    //修改密码
    @RequestMapping("changePass")
    public void changePass(String username,String newPassword){
        System.out.println("----");
        businessService.changePass(username,newPassword);
    }
    //修改密码时，判断账号是否存在
    @RequestMapping("checkExist")
    public Integer checkExist(String username){
        Integer result = businessService.checkExist(username);
        return result;
    }
    //修改密码时，判断手机号和用户名是否匹配 如果匹配则发送验证码
    @RequestMapping("checkUserPhone")
    public Integer checkUserPhone(String username,String phone,HttpServletRequest request){
        Integer integer = businessService.checkUserPhone(username, phone);

        if(integer == 1){
            String code = PhoneIdentify.sendIdentify(phone);
            System.out.println(code);
            request.getSession().setAttribute(phone,code);                 //存入作用域
        }
        return integer;
    }
    //修改密码时，检验手机短信验证码
    @RequestMapping("checkUpdatePhoneCode")
    public Integer checkUpdatePhoneCode(String phone,String phoneCode,HttpSession session){
        String code = (String) session.getAttribute(phone);
        System.out.println(code);
        code.equals(phoneCode);
        if(code.equals(phoneCode)) return 1;
        else return 0;
    }


    //修改密码时验证码  需要联网使用
    @RequestMapping("updateCode")
    public void updateCode(HttpServletResponse response, HttpServletRequest request) throws IOException {
        String text = defaultKaptcha.createText();
        System.out.println(text);
        BufferedImage image = defaultKaptcha.createImage(text);
        ServletOutputStream outputStream = response.getOutputStream();

        request.getSession().setAttribute("code",text); //验证码放入session
        ImageIO.write(image,"png",outputStream);
    }

    //校验修改时验证码
    @RequestMapping("checkCode")
    public Integer checkCode(String code,HttpServletRequest request){
        String sessionCode = (String) request.getSession().getAttribute("code");
        if(code.equals(sessionCode)) return 1;
        else return 0;
    }

    /*商家注册*/
    @RequestMapping("register")
    public void register(Business business){
        businessService.register(business);
    }

    /*注册发送验证码*/
    @RequestMapping("sendPhoneCode")
    public void sendPhoneCode(String phone, HttpServletRequest request){
        String code = PhoneIdentify.sendIdentify(phone);
        request.getSession().setAttribute(phone,code);                 //存入作用域
    }
    /*注册检验验证码*/
    @RequestMapping("checkPhoneCode")
    public String checkPhoneCode(String phone, String code, HttpSession session){
        String phoneCode = (String) session.getAttribute(phone);
        if (code.equals(phoneCode)) return "1";
        else  return "0";
    }
}
