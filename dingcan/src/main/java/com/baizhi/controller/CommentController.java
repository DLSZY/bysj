package com.baizhi.controller;

import com.baizhi.entity.Comment;
import com.baizhi.entity.PageBean;
import com.baizhi.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@RequestMapping("comment")
@RestController
public class CommentController {
    @Autowired
    private CommentService commentService;


    /**
     * 商家
     */
    @RequestMapping("findByBusiness")
    public PageBean findByBusiness(HttpSession session,Integer rows,Integer page){
        String bid = (String) session.getAttribute("businessId");
        PageBean pageBean= commentService.findByBusiness(bid,page,rows);
        return pageBean;
    }
    @RequestMapping("findById")
    public Map<String,Object> findById(String cid){
        return null;
    }

    /**
     * 用户
     */
    @RequestMapping("add")
    public String add(Comment comment, HttpSession session){
        String uid = (String) session.getAttribute("userId");
        comment.setUserId(uid);
        commentService.add(comment);
        return comment.getOrderId();
    }
    @RequestMapping("findByOrder")
    public Comment findByOrder(String oid){
        Comment byOrder = commentService.findByOrder(oid);
        return byOrder;
    }

}
