package com.baizhi.controller;

import com.baizhi.entity.Business;
import com.baizhi.entity.BusinessRefuseReason;
import com.baizhi.entity.PageBean;
import com.baizhi.service.BusinessService;
import com.baizhi.utils.PhoneIdentify;
import com.google.code.kaptcha.impl.DefaultKaptcha;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
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

    /**
    * 用户操作
    * */
    //查询所有正常商家
    @RequestMapping("findAllNormal")
    public List<Business> findAllNormal(){
        return businessService.findAllNormal();
    }
    //根据一级类别查询商家
    @RequestMapping("findByFirst")
    public List<Business> findByFirst(String cateName){
        return businessService.findByFirst(cateName);
    }
    //根据二级类别查询商家
    @RequestMapping("findBySecond")
    public List<Business> findBySecond(String cateName){
        return businessService.findBySecond(cateName);
    }
    //用户根据商家或食品搜索
    @RequestMapping("findBySearch")
    public List<Business> findBySearch(String item,String cate){
        if(cate.equals("商家")){
            return businessService.findByBusiness(item);
        }else {
            return businessService.findByGoods(item);
        }
    }
    //显示商家详情
    @RequestMapping("findById")
    public Business findById(String bid){
        return businessService.findById(bid);
    }


    /**
    * 管理员操作
    * */
    //修改商家的状态
    @RequestMapping("changeStatus")
    public void changeStatue(Business business){
        businessService.changeStatus(business);
    }

    //查询申请的商家
    @RequestMapping("findRegister")
    public PageBean findRegister(Integer page,Integer rows){
        PageBean pageBean = businessService.findBusinessByRegister(page,rows,0);
        return pageBean;
    }
    //查询已经通过申请的商家
    @RequestMapping("findBusiness")
    public PageBean findBusiness(Integer page,Integer rows){
        PageBean pageBean = businessService.findBusinessByRegister(page,rows,1);
        return pageBean;
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


    /**
    * 商家操作
    * */
    //登录
    @RequestMapping("login")
    public Map login(String username,String password,HttpSession session){
        return businessService.login(username,password,session);
    }
    //退出
    @RequestMapping("exit")
    public void exit(HttpSession session){
        session.removeAttribute("businessUsername");
        session.removeAttribute("businessId");
    }
    //查询个人信息
    @RequestMapping("showInfo")
    public Business showInfo(HttpSession session){
        String id = (String) session.getAttribute("businessId");    //从session获取id
        Business info = businessService.findInfo(id);
        return info;
    }
    //修改个人信息
    @RequestMapping("changeInfo")
    public void changeInfo(Business business, MultipartFile multipartFile,HttpServletRequest request) throws IOException {
        //判断是否上传文件
        if(!multipartFile.isEmpty()){
            String realPath = request.getSession().getServletContext().getRealPath("/upload/storeImg");
            String extension = "."+ FilenameUtils.getExtension(multipartFile.getOriginalFilename());
            String imgName = String.valueOf(System.currentTimeMillis());
            File file = new File(realPath +"/"+imgName + extension);
            multipartFile.transferTo(file);
            business.setImgUrl("storeImg/"+imgName+extension);
        }
        System.out.println(business);
        businessService.changeInfo(business);
        System.out.println(multipartFile.getOriginalFilename());
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
    //注册时判断店铺名是否存在
    @RequestMapping("findByName")
    public Integer findByName(String name){
        return businessService.findByName(name);
    }
    //修改密码时，判断手机号和用户名是否匹配 如果匹配则发送验证码
    @RequestMapping("checkUserPhone")
    public Integer checkUserPhone(String username,String phone,HttpServletRequest request){
        Integer integer = businessService.checkUserPhone(username, phone);
        if(integer == 1){
            //正式
            /*String code = PhoneIdentify.sendIdentify(phone);
            System.out.println(code);
            request.getSession().setAttribute(phone,code);      */

            //测试
            request.getSession().setAttribute(phone,"1234");
        }
        return integer;
    }
    //修改密码时，检验手机短信验证码
    @RequestMapping("checkUpdatePhoneCode")
    public Integer checkUpdatePhoneCode(String phone,String phoneCode,HttpSession session){
        System.out.println(phone);
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
    public Integer sendPhoneCode(String phone, HttpServletRequest request){
        Integer byPhone = businessService.findByPhone(phone);
        if (byPhone == 1){
            String code = PhoneIdentify.sendIdentify(phone);
            request.getSession().setAttribute(phone,code);                 //存入作用域
            return 1;
        }else {
            return 0;
        }


    }
    /*注册检验验证码*/
    @RequestMapping("checkPhoneCode")
    public String checkPhoneCode(String phone, String code, HttpSession session){
        String phoneCode = (String) session.getAttribute(phone);
        if (code.equals(phoneCode)) return "1";
        else  return "0";
    }
}
