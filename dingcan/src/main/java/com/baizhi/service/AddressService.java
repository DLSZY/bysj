package com.baizhi.service;

import com.baizhi.entity.Area;
import com.baizhi.entity.City;
import com.baizhi.entity.Province;

import java.util.List;

public interface AddressService {
    List<Province> findProvince();

    List<City> findCity(String provinceCode);

    List<Area> findArea(String cityCode);
}
