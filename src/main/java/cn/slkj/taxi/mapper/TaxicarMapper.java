package cn.slkj.taxi.mapper;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import cn.slkj.taxi.entity.Taxicar;


import cn.slkj.taxi.util.PageData;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;


@Repository
public interface TaxicarMapper {

	public List<Taxicar> getAllList(PageData pd, PageBounds pageBounds);

	public int save(Taxicar taxicar);

	public Taxicar queryOne(PageData pd);

	public int edit(Taxicar taxicar);
	
	int delete(String id);
	
	
	
}