package com.baizhi.service.impl;

import com.baizhi.dao.CommentMapper;
import com.baizhi.entity.*;
import com.baizhi.service.*;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.experimental.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.annotation.Order;

import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentMapper commentMapper;
    @Autowired
    private OrderMasterService masterService;
    @Autowired
    private UserService userService;
    @Autowired
    private OrderDetailService detailService;


    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public PageBean findByBusiness(String bid,Integer pageNow,Integer pageCount) {
        PageHelper.startPage(pageNow,pageCount);
        Comment comment1 = new Comment();
        comment1.setBusinessId(bid);
        List<Comment> comments = commentMapper.select(comment1);
        PageInfo pageInfo = new PageInfo(comments);
        System.out.println(bid+"------");
        for (Comment comment : comments) {
            //设置订单号
            String oid = comment.getOrderId();
            OrderMaster master = masterService.findById(oid);
            comment.setOrderNum(master.getOrderNum());
            //设置用户名
            String uid = comment.getUserId();
            User user = userService.findById(uid);
            comment.setUsername(user.getUsername());
            //设置综合分
            Double allGrade = Double.valueOf(comment.getGoodsGrade()+comment.getPackageGrade()+comment.getDistributeGrade());
            Double average = (double) Math.round(allGrade/3  * 10) / 10;
            comment.setAverage(average);
        }
        PageBean pageBean = new PageBean(pageNow, pageInfo.getTotal(), pageInfo.getPages(), comments);
        return pageBean;
    }

    @Override
    public List<Comment> findByBusi(String bid) {
        Comment comment1 = new Comment();
        comment1.setBusinessId(bid);
        List<Comment> comments = commentMapper.select(comment1);
        for (Comment comment : comments) {
            //设置用户名
            String uid = comment.getUserId();
            User user = userService.findById(uid);
            comment.setUsername(user.getUsername());
            comment.setImgUrl(user.getImgUrl());
            //设置综合分

            Double allGrade = Double.valueOf(comment.getGoodsGrade()+comment.getPackageGrade()+comment.getDistributeGrade());
            Double average = (double) Math.round(allGrade/3  * 10) / 10;
            comment.setAverage(average);
            //设置商品名
            StringBuffer names = new StringBuffer();
            String oid = comment.getOrderId();
            List<OrderDetail> details = detailService.findByOrder(oid);
            for (OrderDetail detail : details) {
                names.append(detail.getGoodsName()+" ");
            }
            comment.setGoodNames(names);
        }
        return comments;
    }

    @Override
    public void add(Comment comment) {
        comment.setId(UUID.randomUUID().toString());
        comment.setCreateDate(new Date());
        //添加评论
        commentMapper.insert(comment);
        //修改订单信息为已评论状态
        String orderId = comment.getOrderId();
        OrderMaster orderMaster = new OrderMaster();
        orderMaster.setId(orderId);
        orderMaster.setIsComment(1);
        masterService.changeIsComment(orderMaster);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Comment findByOrder(String oid) {
        Comment comment = new Comment();
        comment.setOrderId(oid);
        List<Comment> comments = commentMapper.select(comment);
        if(comments.size() == 0){
            return null;
        }else{
            return comments.get(0);
        }
    }


}
