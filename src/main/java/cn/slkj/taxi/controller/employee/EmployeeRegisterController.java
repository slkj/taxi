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
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.slkj.taxi.controller.base.BaseController;
import cn.slkj.taxi.entity.Employee;
import cn.slkj.taxi.entity.EmployeeRegister;
import cn.slkj.taxi.entity.EmployeeReplaceSign;
import cn.slkj.taxi.entity.Role;
import cn.slkj.taxi.entity.User;
import cn.slkj.taxi.service.EmployeeRegisterService;
import cn.slkj.taxi.service.EmployeeService;
import cn.slkj.taxi.util.DateUtil;
import cn.slkj.taxi.util.EPager;
import cn.slkj.taxi.util.JsonResult;
import cn.slkj.taxi.util.PageData;
import cn.slkj.taxi.util.Tools;
import cn.slkj.taxi.util.UuidUtil;

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
@RequestMapping({"/employeeRegister"})
public class EmployeeRegisterController extends BaseController {
	
	@Autowired
	private EmployeeRegisterService employeeRegisterService;
	@Autowired
	private EmployeeService employeeService;

	@RequestMapping({ "/listPage" })
	public ModelAndView listPage() throws Exception {
		ModelAndView mv = new ModelAndView();
		try {			
			mv.setViewName("employee_register/employee_register_list");			
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
		return mv;
	}
	@RequestMapping({ "/checkListPage" })
	public ModelAndView checkListPage(HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("employee_register/employee_register_checklist");
		return mv;
	}
	
	/**
	 * 查询列表，返回easyUI数据格式
	 */
	@ResponseBody
	@RequestMapping(value = "/checkList", method = { RequestMethod.POST })
	public EPager<EmployeeRegister> checkList(HttpSession session) {
		PageData pd = getPageData();
		Integer rows = pd.getIntegr("rows");
		Integer page = pd.getIntegr("page");
		String sortString = "ADDTIME.DESC";// 如果你想排序的话逗号分隔可以排序多列		
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<EmployeeRegister> list = employeeRegisterService.list(pd, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<EmployeeRegister>(pageList.getPaginator().getTotalCount(), list);
	}
	@ResponseBody
	@RequestMapping(value = "/list", method = { RequestMethod.POST })
	public EPager<EmployeeRegister> list(HttpSession session) {
		PageData pd = getPageData();
		Integer rows = pd.getIntegr("rows");
		Integer page = pd.getIntegr("page");
		String sortString = "ADDTIME.DESC";// 如果你想排序的话逗号分隔可以排序多列	
		  User user = (User)session.getAttribute("sessionUser");
		  pd.put("company", user.getDepartName());		 
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<EmployeeRegister> list = employeeRegisterService.list(pd, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<EmployeeRegister>(pageList.getPaginator().getTotalCount(), list);
	}
	
	@RequestMapping("/goAdd")
	public ModelAndView examineAdd() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = getPageData();
		try {
			if ((pd.getString("idcard") != null) && (!"".equalsIgnoreCase(pd.getString("idcard").trim()))) {
				HashMap<String, Object> hashMap = new HashMap<String, Object>();
				hashMap.put("idcard", pd.getString("idcard"));
				hashMap.put("status", "2");
				Employee employee = this.employeeService.selectOne(hashMap);
				mv.addObject("employee", employee);
				
			}
			mv.addObject("msg", "save");
			mv.setViewName("employee_register/employee_register_edit");
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
		return mv;
	}
	
	@RequestMapping("/goEdit")
	public ModelAndView regEdit() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = getPageData();
		try {
			if ((pd.getString("id") != null) && (!"".equalsIgnoreCase(pd.getString("id").trim()))) {
				EmployeeRegister employeeRegister=employeeRegisterService.selectById(pd);
				HashMap<String, Object> hashMap = new HashMap<String, Object>();
				hashMap.put("idcard", employeeRegister.getIdcard());
				hashMap.put("status", "2");
				Employee employee = this.employeeService.selectOne(hashMap);
				mv.addObject("employee", employee);
				mv.addObject("pd", employeeRegister);
			}			
			mv.addObject("msg", "edit");
			mv.setViewName("employee_register/employee_register_edit");
			
		} catch (Exception e) {
			this.logger.error(e.toString(), e);		
		}
		
		return mv;
	}
	
	 @RequestMapping({"/goShow"})
	  public ModelAndView goShow()
	  {
	    ModelAndView mv = new ModelAndView();
	    PageData pd = new PageData();
	    pd = getPageData();
	    try
	    {
	    	EmployeeRegister varList = this.employeeRegisterService.selectById(pd);
	      mv.setViewName("employee_register/employee_register_show");
	      mv.addObject("varList", varList);
	      mv.addObject("msg", "show");
	      mv.addObject("pd", pd);
	    } catch (Exception e) {
	      this.logger.error(e.toString(), e);
	    }
	    return mv;
	  }
	
	@ResponseBody
	@RequestMapping(value = "/save", method = { RequestMethod.POST })
	public boolean save(HttpSession session)  throws Exception{
		
		PageData pd = new PageData();
		try {
			pd = getPageData();
			int rti = 0;
			User user = (User)session.getAttribute("sessionUser");				 
	        pd.put("company", user.getDepartName());
	        pd.put("addtime", DateUtil.getTime());
			String id = pd.getString("id");
			if (Tools.notEmpty(id)) {
				rti = employeeRegisterService.update(pd);
			} else {
				//pd.put("id", UuidUtil.get32UUID());
				pd.put("id", (DateUtil.getDayss() + new Random().nextInt()).substring(0, 15).replace("-", ""));
				rti = employeeRegisterService.insert(pd);
			}
			return rti > 0 ? true : false;
		} catch (Exception e) {System.out.println(e.toString());
			this.logger.error(e.toString(), e);
			return false;
		}
	}
	@ResponseBody
	@RequestMapping(value = "/delete")
	public JsonResult deletes(String id) {
		int i = employeeRegisterService.delete(id);
		try {
			if (i > 0) {
				return new JsonResult(true, "");
			} else {
				return new JsonResult(false, "操作失败！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult(false, e.toString());
		}

	}
	@ResponseBody
	@RequestMapping(value = "/changeStatus")
	public JsonResult changeStatus(@RequestParam(value = "ids[]")String[] ids,String status)  throws Exception {
		PageData pd = new PageData();
		pd = getPageData();
		pd.put("ids", ids);
		pd.put("status", status);
		pd.put("passtime", DateUtil.getTime());
		int i = employeeRegisterService.updateStatus(pd);
		try {
			if (i > 0) {
				if(status=="2"){
				for(int j=0;j<ids.length;j++){
					PageData erpd = new PageData();
					erpd.put("id", ids[j]);
					EmployeeRegister employeeRegister=employeeRegisterService.selectById(erpd);
					//System.out.println(employeeRegister.getCarid()+"&&&&&&&&&&&&&&&");
						PageData mypd = new PageData();
			          mypd.put("carid", employeeRegister.getCarid());
			          mypd.put("cyzgCard", employeeRegister.getIdcard());
			          mypd.put("cartype", employeeRegister.getCartype());
			          mypd.put("idcard", employeeRegister.getIdcard());
			          mypd.put("company", employeeRegister.getCompany());
			          mypd.put("engageConn", employeeRegister.getEngage_conn());
			          mypd.put("engageTime", employeeRegister.getEngage_time());
			          mypd.put("contractSrtCount", employeeRegister.getContract_strcount());
			          mypd.put("contractEndCount", employeeRegister.getContract_endcount());
			          mypd.put("registerDate", employeeRegister.getPasstime());
			          //mypd.put("cancelDate", "");
			          this.employeeService.updateByIDCard(mypd);
				}
				}
				return new JsonResult(true, "");
			} else {
				return new JsonResult(false, "操作失败！");
			}
		} catch (Exception e) {System.out.println(e.toString());
			e.printStackTrace();
			return new JsonResult(false, e.toString());
		}

	}
}
