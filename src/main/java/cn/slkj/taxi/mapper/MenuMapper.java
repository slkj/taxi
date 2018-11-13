package cn.slkj.taxi.mapper;

import java.util.List;

import cn.slkj.taxi.entity.Menu;
import cn.slkj.taxi.util.PageData;

public interface MenuMapper {

	public List<Menu> listAllParentMenu(PageData pd);

	public List<Menu> listAllMenu(PageData pd);

	public int save(PageData pd);

	public int edit(PageData pd);

	public int delete(String id);

	public List<Menu> getSubMenu(PageData pd);

}
