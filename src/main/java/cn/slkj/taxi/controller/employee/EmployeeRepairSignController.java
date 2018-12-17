/**  
 * @Title:  EmployeeRegisterController.java   
 * @Package cn.slkj.taxi.controller.employee   
 * @Description:    TODO(用一句话描述该文件做什么)   
 * @author: maxh     
 * @date:   2018年11月16日 下午12:06:40   
 * @version V1.0 
 */
package cn.slkj.taxi.controller.employee;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.slkj.taxi.controller.base.BaseController;
import cn.slkj.taxi.entity.EmployeeRepairSign;
import cn.slkj.taxi.service.EmployeeRepairSignService;
import cn.slkj.taxi.util.EPager;
import cn.slkj.taxi.util.PageData;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;

/**
 * @ClassName: EmployeeRegisterController
 * @Description: 从业资格注册
 * @author: maxh
 * @date: 2018年11月16日 下午12:06:40
 * 
 */
@Controller
@RequestMapping({"/employeeRepairSign"})
public class EmployeeRepairSignController extends BaseController {
	
	@Autowired
	private EmployeeRepairSignService employeeRepairSignService;

	@RequestMapping({ "/listPage" })
	public ModelAndView listPage() throws Exception {
		ModelAndView mv = new ModelAndView();
		try {			
			mv.setViewName("employee_repair_sign/employee_repair_sign_list");			
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
		return mv;
	}
	@RequestMapping({ "/fircheckListPage" })
	public ModelAndView fircheckListPage(HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("employee_repair_sign/employee_repair_sign_firchecklist");
		return mv;
	}
	@RequestMapping({ "/seccheckListPage" })
	public ModelAndView seccheckListPage(HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("employee_repair_sign/employee_repair_sign_secchecklist");
		return mv;
	}
	
	/**
	 * 查询列表，返回easyUI数据格式
	 */
	@ResponseBody
	@RequestMapping(value = "/list", method = { RequestMethod.POST })
	public EPager<EmployeeRepairSign> list(HttpSession session) {
		PageData pd = getPageData();
		Integer rows = pd.getIntegr("rows");
		Integer page = pd.getIntegr("page");
		String sortString = "ADDTIME.DESC";// 如果你想排序的话逗号分隔可以排序多列
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<EmployeeRepairSign> list = employeeRepairSignService.list(pd, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<EmployeeRepairSign>(pageList.getPaginator().getTotalCount(), list);
	}
	/**
	 * 查询列表，返回easyUI数据格式
	 */
	@ResponseBody
	@RequestMapping(value = "/firstCheckList", method = { RequestMethod.POST })
	public EPager<EmployeeRepairSign> firstCheckList(HttpSession session) {
		PageData pd = getPageData();
		Integer rows = pd.getIntegr("rows");
		Integer page = pd.getIntegr("page");
		String sortString = "ADDTIME.DESC";// 如果你想排序的话逗号分隔可以排序多列
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<EmployeeRepairSign> list = employeeRepairSignService.list(pd, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<EmployeeRepairSign>(pageList.getPaginator().getTotalCount(), list);
	}
	@ResponseBody
	@RequestMapping(value = "/secondCheckList", method = { RequestMethod.POST })
	public EPager<EmployeeRepairSign> secondCheckList(HttpSession session) {
		PageData pd = getPageData();
		Integer rows = pd.getIntegr("rows");
		Integer page = pd.getIntegr("page");
		String sortString = "ADDTIME.DESC";// 如果你想排序的话逗号分隔可以排序多列
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<EmployeeRepairSign> list = employeeRepairSignService.list(pd, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<EmployeeRepairSign>(pageList.getPaginator().getTotalCount(), list);
	}
}
