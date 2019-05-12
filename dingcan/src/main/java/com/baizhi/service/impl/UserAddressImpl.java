package com.baizhi.service.impl;

import com.baizhi.dao.AddressMapper;
import com.baizhi.entity.Address;
import com.baizhi.service.UserAddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class UserAddressImpl implements UserAddressService {
    @Autowired
    private AddressMapper addressMapper;

    @Override
    public void add(Address address) {
        address.setId(UUID.randomUUID().toString());
        addressMapper.insert(address);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<Address> findByUser(String uid) {
        Address address = new Address();
        address.setUserId(uid);
        List<Address> list = addressMapper.select(address);
        return list;
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Address findById(String id) {
        Address address = new Address();
        address.setId(id);
        List<Address> list = addressMapper.select(address);
        return list.get(0);
    }

    @Override
    public void Update(Address address) {
        addressMapper.updateByPrimaryKey(address);
    }

    @Override
    public void del(String id) {
        addressMapper.deleteByPrimaryKey(id);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Address findByOrder(String oid) {
        Address address = addressMapper.findByOrder(oid);
        return address;
    }
}
