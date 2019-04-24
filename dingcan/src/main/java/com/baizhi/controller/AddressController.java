package com.baizhi.controller;

import com.baizhi.entity.Area;
import com.baizhi.entity.City;
import com.baizhi.entity.Province;
import com.baizhi.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequestMapping("address")
@RestController
public class AddressController {
    @Autowired
    private AddressService addressService;

    @RequestMapping("findAllProvince")
    public List<Province> findAllProvince(){
        List<Province> provinces = addressService.findProvince();
        return provinces;
    }

    @RequestMapping("findCity")
    public List<City> findCity(String provinceId){
        List<City> citys = addressService.findCity(provinceId);
        return citys;
    }

    @RequestMapping("findArea")
    public List<Area> findArea(String cityCode){
        List<Area> areas = addressService.findArea(cityCode);
        return areas;
    }


}
