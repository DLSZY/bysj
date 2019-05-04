package com.baizhi.controller;

import com.baizhi.dao.GoodsCateinstoreMapper;
import com.baizhi.entity.Goods;
import com.baizhi.entity.GoodsCate;
import com.baizhi.entity.GoodsCateinstore;
import com.baizhi.entity.PageBean;
import com.baizhi.service.CateInStoreService;
import com.baizhi.service.CategoryService;
import com.baizhi.service.GoodsService;
import com.baizhi.service.impl.GoodsServiceImpl;
import com.github.pagehelper.Page;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("goods")
public class GoodsController {

    @Autowired
    private CategoryService categoryService;
    @Autowired
    private CateInStoreService cateInStoreService;
    @Autowired
    private GoodsService goodsService;


    /*
    * 后台
    * */
    @RequestMapping("findAll")
    public PageBean findAll(Integer page,Integer rows){
        return goodsService.findAll(page,rows);
    }
    //查看商品详情
    @RequestMapping("findOneNoOther")
    public Goods findOneNoOther(String id){
        return goodsService.findOne(id);
    }


    /*
    * 商家
    * */
    //删除
    @RequestMapping("delete")
    public void delete(String id){
        goodsService.delete(id);
    }
    //查看商品详情
    @RequestMapping("findOne")
    public Map<String,Object> findOne(String id, HttpSession session){
        Map<String,Object> map = new HashMap<>();
        map.put("goods",goodsService.findOne(id));
        map.put("cate",categoryService.findCateByLevel(2));
        String businessId = (String) session.getAttribute("businessId");
        map.put("cateinstore",cateInStoreService.findAll(businessId));
        return map;
    }
    //分页查询本店食品
    @RequestMapping("findFood")
    public PageBean findFood(Integer page,Integer rows,HttpSession session){
        String businessId = (String) session.getAttribute("businessId");
        return goodsService.findFood(page,rows,businessId);
    }

    //查询所有食品二级类别
    @RequestMapping("findCate")
    public List<GoodsCate> findCate(){
        List<GoodsCate> cates = categoryService.findCateByLevel(2);
        return cates;
    }

    //查询本店商品类别
    @RequestMapping("findCateInStore")
    public List<GoodsCateinstore> findCateInStore(HttpSession session){
        String businessId = (String) session.getAttribute("businessId");
        return cateInStoreService.findAll(businessId);
    }

    //添加修改食品
    @RequestMapping("add")
    public void add(MultipartFile multipartFile, Goods goods, HttpServletRequest request) throws IOException {
        System.out.println(multipartFile.isEmpty());
        //判断是否上传文件
        if(!multipartFile.isEmpty()){
            String realPath = request.getSession().getServletContext().getRealPath("/upload/goodsImg");
            String extension = "."+ FilenameUtils.getExtension(multipartFile.getOriginalFilename());
            String imgName = String.valueOf(System.currentTimeMillis());
            File file = new File(realPath +"/"+imgName + extension);
            multipartFile.transferTo(file);
            goods.setImgUrl(imgName+extension);
        }
        //添加
        if(StringUtils.isEmpty(goods.getId())){
            goods.setBusinessId((String) request.getSession().getAttribute("businessId"));   //从session获取
            goodsService.add(goods);
        }else{
            goodsService.update(goods);
        }
    }





}
