/**
 * 
 */
package cn.slkj.taxi.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;

import cn.slkj.taxi.controller.base.BaseController;
import cn.slkj.taxi.entity.Employee;
import cn.slkj.taxi.entity.User;
import cn.slkj.taxi.service.EmployeeService;
import cn.slkj.taxi.util.Const;
import cn.slkj.taxi.util.EPager;

/**
 * 
 * 从业人员管理
 * 
 * @author maxuh
 *
 */

@Controller
@RequestMapping({ "/employee" })
public class EmployeeController extends BaseController{
	@Autowired
	private EmployeeService employeeService;

	// 人员信息页面
	@RequestMapping("/employeeListPage")
	public String employeeListPage() {
		return "employee/employeeList";
	}

	// 新报名人员页面
	@RequestMapping("/employeeListPage0")
	public String employeeListPage0() {
		return "employee/employee_list0";
	}

	@RequestMapping({ "/listPage/{changeNum}" })
	public ModelAndView list(@PathVariable("changeNum") String changeNum) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (changeNum.equals("9")) {
			mv.setViewName("employee/employee_list");
		} else if (changeNum.equals("0")) {
			mv.setViewName("employee/employee_list0");
		} else if (changeNum.equals("1")) {
			mv.setViewName("employee/employee_list1");
		} else if (changeNum.equals("2")) {
			mv.setViewName("employee/employee_list2");
		} else if (changeNum.equals("3")) {
			mv.setViewName("employee/employee_list3");
		}
		return mv;
	}

	@RequestMapping({ "/goAdd" })
	public ModelAndView goAdd() {
		ModelAndView mv = new ModelAndView();
		try {
			HashMap<String, Object> hashMapCom = new HashMap<String, Object>();
//			List<Company> enterpriseInfo = companyService.queryComList(hashMapCom);
			mv.setViewName("employee/employee_edit");
//			mv.addObject("enterpriseInfo", enterpriseInfo);
			mv.addObject("msg", "save");
			mv.addObject("status", Integer.valueOf(3));
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 编辑页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "/goEdit" })
	public ModelAndView goEdit(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		try {
			HashMap<String, Object> hashMap = new HashMap<String, Object>();
			hashMap.put("id", request.getParameter("id"));
			Employee ep = this.employeeService.selectOne(hashMap);
			HashMap<String, Object> hashMapCom = new HashMap<String, Object>();
//			List<Company> enterpriseInfo = companyService.queryComList(hashMapCom);
			mv.setViewName("employee/employee_edit");
//			mv.addObject("enterpriseInfo", enterpriseInfo);
			mv.addObject("msg", "edit");
			mv.addObject("pd", ep);
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 详细信息页面
	 * 
	 * @return
	 */
	@RequestMapping({ "/goShow" })
	public ModelAndView goShow(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		try {
			// String flag = pd.getString("flag");

			HashMap<String, Object> hashMap = new HashMap<String, Object>();
			hashMap.put("id", request.getParameter("id"));
			Employee ep = this.employeeService.selectOne(hashMap);

			// List<PageData> varList = this.employeeOrganService.listForShow(pd);
			// List<PageData> rank =
			// this.employeeService.getEmployeeRank(pd.getString("ID"));
			// List<PageData> continueRegister =
			// this.employeeService.getEmployeeContinueRegister(pd.getString("ID"));
			// mv.addObject("varList", varList);
			// mv.addObject("flag", flag);
			mv.addObject("msg", "show");
			mv.addObject("pd", ep);
			// mv.addObject("rank", rank);
			// mv.addObject("continueRegister", continueRegister);
			mv.setViewName("employee/employee_show");
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 查询列表，返回easyUI数据格式
	 */
	@ResponseBody
	@RequestMapping(value = "/employeeList", method = { RequestMethod.POST })
	public EPager<Employee> employeeList(HttpServletRequest request, HttpSession session, @RequestParam(required = false, defaultValue = "1") Integer page,
			@RequestParam(required = false, defaultValue = "20") Integer rows) {
		String sortString = "ADDTIME.DESC,PERSONAL_ID.ASC,";// 如果你想排序的话逗号分隔可以排序多列
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("name", request.getParameter("name"));
		hashMap.put("status", request.getParameter("status"));
		hashMap.put("company", request.getParameter("company"));
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<Employee> list = employeeService.listPage(hashMap, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<Employee>(pageList.getPaginator().getTotalCount(), list);
	}

	@RequestMapping({ "/delete" })
	public boolean delete(HttpServletRequest request) throws Exception {
		int i = employeeService.deleteById(request.getParameter("id"));
		try {
			if (i > 0) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	/**
	 * 考试报名页面
	 * 
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({ "/signuplist" })
	public String signuplist() {
		return "signup/signup_list";
	}

	/**
	 * 查询列表，返回easyUI数据格式
	 */
	@ResponseBody
	@RequestMapping(value = "/slistPage", method = { RequestMethod.POST })
	public EPager<Employee> slistPage(HttpServletRequest request, HttpSession session, @RequestParam(required = false, defaultValue = "1") Integer page,
			@RequestParam(required = false, defaultValue = "20") Integer rows) {
		String sortString = "ADDTIME.DESC";// 如果你想排序的话逗号分隔可以排序多列
		User user = (User) session.getAttribute(Const.SESSION_USER);
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("company", user.getDepartName());
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<Employee> list = employeeService.slistPage(hashMap, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<Employee>(pageList.getPaginator().getTotalCount(), list);
	}

}
