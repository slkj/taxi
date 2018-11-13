package cn.slkj.taxi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.slkj.taxi.entity.Menu;
import cn.slkj.taxi.mapper.MenuMapper;
import cn.slkj.taxi.util.PageData;

/*
 * 
 */
@Service
public class MenuService {
	@Autowired
	private MenuMapper menuMapper;

	public List<Menu> listAllParentMenu(PageData pd) {
		return menuMapper.listAllParentMenu(pd);
	}

	public List<Menu> listAllMenu(PageData pd) {
		return menuMapper.listAllMenu(pd);
	}
}
