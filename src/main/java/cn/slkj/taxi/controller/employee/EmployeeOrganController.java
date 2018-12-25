/**
 * 
 */
package cn.slkj.taxi.controller.employee;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cn.slkj.taxi.controller.base.BaseController;
import cn.slkj.taxi.entity.EmployeeOrgan;
import cn.slkj.taxi.entity.User;
import cn.slkj.taxi.service.EmployeeOrganService;
import cn.slkj.taxi.util.Const;
import cn.slkj.taxi.util.DateUtil;
import cn.slkj.taxi.util.EPager;
import cn.slkj.taxi.util.FileUtil;
import cn.slkj.taxi.util.PageData;
import cn.slkj.taxi.util.Tools;
import cn.slkj.taxi.util.UuidUtil;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;

/**
 * 
 * 从业人员管理
 * 
 * @author maxuh
 *
 */

@Controller
@RequestMapping({ "/employeeOrgan" })
public class EmployeeOrganController extends BaseController {
	@Autowired
	private EmployeeOrganService employeeOrganService;


	@RequestMapping({ "/listPage" })
	public ModelAndView list() throws Exception {
		ModelAndView mv = new ModelAndView();		
		mv.setViewName("employee_organ/employee_organ_list");
		return mv;
	}

	@RequestMapping({ "/goAdd" })
	public ModelAndView goAdd() {
		ModelAndView mv = new ModelAndView();
		try {
			HashMap<String, Object> hashMapCom = new HashMap<String, Object>();
			// List<Company> enterpriseInfo = companyService.queryComList(hashMapCom);
			mv.setViewName("employee_organ/employee_organ_edit");
			// mv.addObject("enterpriseInfo", enterpriseInfo);
			mv.addObject("msg", "save");
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
			EmployeeOrgan ep = employeeOrganService.selectOne(hashMap);
			HashMap<String, Object> hashMapCom = new HashMap<String, Object>();
			// List<Company> enterpriseInfo = companyService.queryComList(hashMapCom);
			mv.setViewName("employee_organ/employee_organ_edit");
			// mv.addObject("enterpriseInfo", enterpriseInfo);
			mv.addObject("msg", "edit");
			mv.addObject("pd", ep);
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
		return mv;
	}

	

	/**
	 * 查询列表，返回easyUI数据格式
	 */
	@ResponseBody
	@RequestMapping(value = "/employeeOrganList", method = { RequestMethod.POST })
	public EPager<EmployeeOrgan> employeeList(HttpSession session) {
		PageData pd = getPageData();
		Integer rows = pd.getIntegr("rows");
		Integer page = pd.getIntegr("page");
		String sortString = "ADD_DATE.DESC";// 如果你想排序的话逗号分隔可以排序多列
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("parent_id", pd.getString("parent_id"));
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<EmployeeOrgan> list = employeeOrganService.list(hashMap, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<EmployeeOrgan>(pageList.getPaginator().getTotalCount(), list);
	}

	@ResponseBody
	@RequestMapping({ "/delete" })
	public boolean delete() throws Exception {
		PageData pd = getPageData();
		int rti = employeeOrganService.delete(pd.getString("id"));
		return rti > 0 ? true : false;
	}

	

	@ResponseBody
	@RequestMapping({ "/save" })
	public boolean save() throws Exception {
		
		PageData pd = new PageData();
		try {
			pd = getPageData();
			int rti = 0;
			String id = pd.getString("id");
			if (Tools.notEmpty(id)) {
				rti = employeeOrganService.update(pd);
			} else {
				pd.put("id", UuidUtil.get32UUID());
				rti = employeeOrganService.insert(pd);
			}
			return rti > 0 ? true : false;
		} catch (Exception e) {System.out.println(e.toString());
			this.logger.error(e.toString(), e);
			return false;
		}
	}
	
}
