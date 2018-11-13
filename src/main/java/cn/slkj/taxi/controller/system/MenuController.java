package cn.slkj.taxi.controller.system;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.slkj.taxi.controller.base.BaseController;
import cn.slkj.taxi.entity.Menu;
import cn.slkj.taxi.service.MenuService;
import cn.slkj.taxi.util.PageData;

@Controller
@RequestMapping("/menu")
public class MenuController extends BaseController {
	@Autowired
	private MenuService menuService;

	@RequestMapping("/menusPage")
	public String toMenusPage() {
		return "system/menu/menu_list";
	}

	@ResponseBody
	@RequestMapping(value = "/listAllParentMenu")
	public List<Menu> listAllParentMenu() {
		PageData pd = getPageData();
		return menuService.listAllParentMenu(pd);
	}

	@ResponseBody
	@RequestMapping(value = "/listMenuTree")
	public List<Menu> listMenuTree() {
		PageData pd = getPageData();
		List<Menu> list = menuService.listAllMenu(pd);
		return makeTree(list);
	}

	/**
	 * 组装树形列表 treegrid
	 * 
	 * @param list
	 * @return
	 */
	private List<Menu> makeTree(List<Menu> list) {
		List<Menu> parent = new ArrayList<Menu>();
		for (Menu e : list) {
			if (e.getParent_id().equals("0")) {
				e.setChildren(new ArrayList<Menu>(0));
				parent.add(e);
			}
		}
		list.removeAll(parent);
		makeChildren(parent, list);
		return parent;
	}

	private void makeChildren(List<Menu> parent, List<Menu> children) {
		if (children.isEmpty()) {
			return;
		}
		List<Menu> tmp = new ArrayList<Menu>();
		for (Menu c1 : parent) {
			for (Menu c2 : children) {
				c2.setChildren(new ArrayList<Menu>(0));
				if (c1.getId().equals(c2.getParent_id())) {
					c1.getChildren().add(c2);
					if (!c1.getParent_id().equals("0")) {
						c1.setState("closed");
					}
					tmp.add(c2);
				}
			}
		}
		children.removeAll(tmp);
		makeChildren(tmp, children);
	}
}
