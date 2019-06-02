package com.baizhi.conf;

import com.baizhi.interceptor.AdminInterceptor;
import com.baizhi.interceptor.BusinessInterceptor;
import com.baizhi.interceptor.UserInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
public class InterceptorConf extends WebMvcConfigurerAdapter {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
          //用户拦截器
          registry.addInterceptor(new UserInterceptor())
                .addPathPatterns("/user/changePass")
                .addPathPatterns("/user/changePass")
                .addPathPatterns("/user/findInfo")
                .addPathPatterns("/user/change")
                .addPathPatterns("/user/judge")
                .addPathPatterns("/business/findAllNormal")
                .addPathPatterns("/business/findByFirst")
                .addPathPatterns("/business/findBySecond")
                .addPathPatterns("/business/findBySearch")
                .addPathPatterns("/business/findById")
                .addPathPatterns("/cart/add")
                .addPathPatterns("/cart/findByUser")
                .addPathPatterns("/cart/findByUserAndBuss")
                .addPathPatterns("/cart/editCount")
                .addPathPatterns("/cart/allPrice")
                .addPathPatterns("/goods/findByCateInsStore")
                .addPathPatterns("/orderMaster/findByUser")
                .addPathPatterns("/orderMaster/del")
                .addPathPatterns("/orderMaster/add")
                .addPathPatterns("/userAddress/del")
                .addPathPatterns("/userAddress/edit")
                .addPathPatterns("/userAddress/selectByUser")
                .addPathPatterns("/userAddress/selectById")
                .addPathPatterns("/category/selectByFirstName")
                .addPathPatterns("/cateInStore/findByBusiness");

          //商家拦截器
          registry.addInterceptor(new BusinessInterceptor())
                .addPathPatterns("/business/showInfo")
                .addPathPatterns("/business/changeInfo")
                .addPathPatterns("/comment/findByBusiness")
                .addPathPatterns("/goods/delete")
                .addPathPatterns("/goods/findOne")
                .addPathPatterns("/goods/findFood")
                .addPathPatterns("/goods/add")
                .addPathPatterns("/orderMaster/findByBusinessPage")
                .addPathPatterns("/reduce/**")
                .addPathPatterns("/address/findAllProvince")
                .addPathPatterns("/cateInStore/add")
                .addPathPatterns("/cateInStore/findAll")
                .addPathPatterns("/cateInStore/delete")
                .excludePathPatterns("/business/login")
                .excludePathPatterns("/reduce/findByBusiness");

          //管理员拦截器
          registry.addInterceptor(new AdminInterceptor())
                  .addPathPatterns("/business/changeStatus")
                  .addPathPatterns("/business/findRegister")
                  .addPathPatterns("/business/findBusiness")
                  .addPathPatterns("/business/passRegister")
                  .addPathPatterns("/business/refuseRegister")
                  .addPathPatterns("/category/selectByLevelAndPage")
                  .addPathPatterns("/category/add")
                  .addPathPatterns("/category/deleteSecond")
                  .addPathPatterns("/category/deleteFirst")
                  .addPathPatterns("/orderMaster/findByPage")
                  .addPathPatterns("/user/findAll")
                  .addPathPatterns("/user/changeStatus")
                  .addPathPatterns("/goods/findOneNoOther")
                  .addPathPatterns("/goods/findAll");
        }
}
