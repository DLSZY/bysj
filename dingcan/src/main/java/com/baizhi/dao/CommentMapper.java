package com.baizhi.dao;

import com.baizhi.entity.Comment;
import java.util.List;

public interface CommentMapper {
    int deleteByPrimaryKey(String id);

    int insert(Comment record);

    Comment selectByPrimaryKey(String id);

    List<Comment> selectAll();

    int updateByPrimaryKey(Comment record);
}