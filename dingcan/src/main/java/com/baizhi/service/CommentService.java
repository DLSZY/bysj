package com.baizhi.service;

import com.baizhi.entity.Comment;
import com.baizhi.entity.PageBean;
import com.github.pagehelper.Page;

import java.util.List;

public interface CommentService {

    /**
     * 商家
     */
    //查询本店评论
    PageBean findByBusiness(String bid,Integer pageNow,Integer pageCount);

    /**
     * 用户
     */
    //添加评论
    void add (Comment comment);
    //根据订单查询评论
    Comment findByOrder(String oid);
    //在商家页显示商家评论
    List<Comment> findByBusi(String bid);
}
