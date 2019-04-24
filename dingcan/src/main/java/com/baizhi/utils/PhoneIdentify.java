package com.baizhi.utils;

import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;

import javax.servlet.http.HttpServletRequest;

public class PhoneIdentify {

    public static String sendIdentify(String phone,HttpServletRequest httpServletRequest){
        DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", "LTAIV8ObMnhcdqzn", "W3HQ3qhqsRbfm9IA27pAEujlTAhorf");
        IAcsClient client = new DefaultAcsClient(profile);

        CommonRequest request = new CommonRequest();
        //request.setProtocol(ProtocolType.HTTPS);
        request.setMethod(MethodType.POST);
        request.setDomain("dysmsapi.aliyuncs.com");
        request.setVersion("2017-05-25");
        request.setAction("SendSms");
        request.putQueryParameter("RegionId", "cn-hangzhou");
        request.putQueryParameter("PhoneNumbers", phone);
        request.putQueryParameter("SignName", "石头DZY");
        request.putQueryParameter("TemplateCode", "SMS_163431885");
        String code = PhoneVerifyCodeUtil.generateVerifyCode(4);
        httpServletRequest.getSession().setAttribute(phone,code);                 //存入作用域
        request.putQueryParameter("TemplateParam", "{\"code\":\""+code+"\"}");
        try {
            CommonResponse response = client.getCommonResponse(request);
            System.out.println(response.getData());
        } catch (ServerException e) {
            e.printStackTrace();
        } catch (ClientException e) {
            e.printStackTrace();
        }
        return code;
    }
}
