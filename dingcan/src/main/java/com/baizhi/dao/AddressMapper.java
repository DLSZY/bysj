package com.baizhi.dao;

import com.baizhi.entity.Address;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface AddressMapper extends Mapper<Address> {
    Address findByOrder (String oid);
}