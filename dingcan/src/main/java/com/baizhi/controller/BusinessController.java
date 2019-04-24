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
    /*商家注册*/

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
    //校验验证码
    @RequestMapping("checkCode")
    public Integer checkCode(String code,HttpServletRequest request){
        String sessionCode = (String) request.getSession().getAttribute("code");
        if(code.equals(sessionCode)) return 1;
        else return 0;
    }



    @RequestMapping("register")
    public void register(Business business){
        businessService.register(business);
    }

    /*注册发送验证码*/
    @RequestMapping("sendPhoneCode")
    public Map<String,String> sendPhoneCode(String phone, HttpServletRequest request){
        System.out.println(phone);
        Map<String,String> map = new HashMap<>();
        String code = PhoneIdentify.sendIdentify(phone, request);
        map.put(phone,code);
        return map;
    }
    /*注册检验验证码*/
    @RequestMapping("checkPhoneCode")
    public String checkPhoneCode(String phone, String code, HttpSession session){
        String phoneCode = (String) session.getAttribute(phone);
        if (code.equals(phoneCode)) return "1";
        else  return "0";
    }
}
