package com.baizhi.controller;

import com.baizhi.dao.GoodsCateinstoreMapper;
import com.baizhi.entity.Goods;
import com.baizhi.entity.GoodsCate;
import com.baizhi.entity.GoodsCateinstore;
import com.baizhi.service.CateInStoreService;
import com.baizhi.service.CategoryService;
import com.baizhi.service.GoodsService;
import com.baizhi.service.impl.GoodsServiceImpl;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;
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

    //查询所有食品二级类别
    @RequestMapping("findCate")
    public List<GoodsCate> findCate(){
        List<GoodsCate> cates = categoryService.findCateByLevel(2);
        return cates;
    }

    //查询本店商品类别
    @RequestMapping("findCateInStore")
    public List<GoodsCateinstore> findCateInStore(){
        return cateInStoreService.findAll();
    }

    //添加食品
    @RequestMapping("add")
    public void add(MultipartFile multipartFile, Goods goods, HttpServletRequest request) throws IOException {
        System.out.println(goods);
        System.out.println(multipartFile.getOriginalFilename());

        //文件上传
        String realPath = request.getSession().getServletContext().getRealPath("/upload/goodsImg");
        String extension = "."+ FilenameUtils.getExtension(multipartFile.getOriginalFilename());
        String imgName = String.valueOf(System.currentTimeMillis());
        File file = new File(realPath +"/"+imgName + extension);
        multipartFile.transferTo(file);

        goods.setBusinessId("1");   //从session获取
        goods.setImgUrl(imgName+extension);
        goodsService.add(goods);
    }






}
