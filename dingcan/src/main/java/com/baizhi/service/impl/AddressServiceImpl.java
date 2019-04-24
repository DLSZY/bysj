package com.baizhi.service.impl;

import com.baizhi.dao.AreaMapper;
import com.baizhi.dao.CityMapper;
import com.baizhi.dao.ProvinceMapper;
import com.baizhi.entity.Area;
import com.baizhi.entity.City;
import com.baizhi.entity.Province;
import com.baizhi.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

@Service
@Transactional
public class AddressServiceImpl implements AddressService {

    @Autowired
    private ProvinceMapper provinceMapper;
    @Autowired
    private CityMapper cityMapper;
    @Autowired
    private AreaMapper areaMapper;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<Province> findProvince() {
        List<Province> provinces = provinceMapper.selectAll();
        return provinces;
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<City> findCity(String provinceCode) {
        Example example = new Example(City.class);
        example.createCriteria().andEqualTo("provinceCode",provinceCode);
        List<City> cities = cityMapper.selectByExample(example);
        return cities;
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<Area> findArea(String cityCode) {
        Example example = new Example(Area.class);
        example.createCriteria().andEqualTo("cityCode",cityCode);
        List<Area> areas = areaMapper.selectByExample(example);
        return areas;
    }
}
