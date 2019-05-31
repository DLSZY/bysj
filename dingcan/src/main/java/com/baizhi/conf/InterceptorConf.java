package com.baizhi.conf;

import com.baizhi.interceptor.BusinessInterceptor;
import com.baizhi.interceptor.UserInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
public class InterceptorConf extends WebMvcConfigurerAdapter {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
         /* registry.addInterceptor(new UserInterceptor())
                    .addPathPatterns("/user/**")
                    .excludePathPatterns("/user/login");*/

          //商家连接器
          registry.addInterceptor(new BusinessInterceptor())
                    .addPathPatterns("/business/showInfo")
                    .addPathPatterns("/business/changeInfo")
                    .addPathPatterns("/cateInStore/**")
                    .addPathPatterns("/comment/findByBusiness")
                    .addPathPatterns("/goods/delete")
                    .addPathPatterns("/goods/findOne")
                    .addPathPatterns("/goods/findFood")
                    .addPathPatterns("/goods/add")
                    .addPathPatterns("/orderMaster/findByBusinessPage")
                    .addPathPatterns("/reduce/**")
                    .excludePathPatterns("/business/login");
        }
}
