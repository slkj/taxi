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
import cn.slkj.taxi.entity.EmployeeCancel;
import cn.slkj.taxi.service.EmployeeCancelService;
import cn.slkj.taxi.util.EPager;
import cn.slkj.taxi.util.PageData;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;

/**
 * 
 * @ClassName:  EmployeeCancelController   
 * @Description:资格证注销 
 * @author: wangling 
 * @date:   2018年12月10日 上午10:17:30   
 *
 */
@Controller
@RequestMapping({"/employeeCancel"})
public class EmployeeCancelController extends BaseController {
	
	@Autowired
	private EmployeeCancelService employeeCancelService;

	@RequestMapping({ "/listPage" })
	public ModelAndView listPage() throws Exception {
		ModelAndView mv = new ModelAndView();
		try {			
			mv.setViewName("employee_cancel/employee_cancel_list");			
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
		return mv;
	}
	@RequestMapping({ "/checkListPage" })
	public ModelAndView checkList(HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("employee_cancel/employee_cancel_checklist");
		return mv;
	}
	
	/**
	 * 查询列表，返回easyUI数据格式
	 */
	@ResponseBody
	@RequestMapping(value = "/list", method = { RequestMethod.POST })
	public EPager<EmployeeCancel> employeeList(HttpSession session) {
		PageData pd = getPageData();
		Integer rows = pd.getIntegr("rows");
		Integer page = pd.getIntegr("page");
		String sortString = "ADDTIME.DESC";// 如果你想排序的话逗号分隔可以排序多列
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("name", pd.getString("name"));
		hashMap.put("status", pd.getString("status"));
		hashMap.put("company", pd.getString("company"));
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<EmployeeCancel> list = employeeCancelService.list(hashMap, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<EmployeeCancel>(pageList.getPaginator().getTotalCount(), list);
	}
}
