package cn.slkj.taxi.controller.system;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;

import cn.slkj.taxi.controller.base.BaseController;
import cn.slkj.taxi.entity.Role;
import cn.slkj.taxi.entity.User;
import cn.slkj.taxi.service.UserService;
import cn.slkj.taxi.util.EPager;
import cn.slkj.taxi.util.PageData;

/**
 * 
 * @ClassName: UserController
 * @Description: 用户信息
 * @author maxh
 *
 */
@Controller
@RequestMapping(value = "/user")
@SessionAttributes("userSession")
public class UserController extends BaseController {
	@Resource
	private UserService userService;

	/* 跳转页面 */
	@RequestMapping("/userListPage")
	public String userListPage() {
		return "system/user/user_List";
	}

	@ResponseBody
	@RequestMapping(value = "list")
	public EPager<User> getAllParam() throws IOException {
		String sortString = "";
		PageData pd = new PageData();
		pd = getPageData();
		Integer rows = pd.getIntegr("rows");
		Integer page = pd.getIntegr("page");

		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<User> list = userService.getAllUsers(pd, pageBounds);
		PageList<User> pageList = (PageList<User>) list;
		return new EPager<User>(pageList.getPaginator().getTotalCount(), list);
	}

	@ResponseBody
	@RequestMapping(value = { "/add" }, method = { RequestMethod.POST })
	public boolean add() throws Exception {
		PageData pd = new PageData();
		try {
			pd = getPageData();
			int i = userService.saveUser(pd);
			return i > 0 ? true : false;
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
			return false;
		}
	}
	@ResponseBody
	@RequestMapping({ "/delete" })
	
	public boolean delete(@RequestParam String id) throws Exception {
		try {
			int i = userService.deleteUser(id);
			return i > 0 ? true : false;
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
			return false;
		}
	}
}
