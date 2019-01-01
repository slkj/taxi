/**  
 * @Title:  EmployeeRegisterController.java   
 * @Package cn.slkj.taxi.controller.employee   
 * @Description:    TODO(用一句话描述该文件做什么)   
 * @author: maxh     
 * @date:   2018年11月16日 下午12:06:40   
 * @version V1.0 
 */
package cn.slkj.taxi.controller.employee;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.slkj.taxi.controller.base.BaseController;
import cn.slkj.taxi.entity.Employee;
import cn.slkj.taxi.entity.EmployeeRank;
import cn.slkj.taxi.entity.User;
import cn.slkj.taxi.service.EmployeeRankService;
import cn.slkj.taxi.service.EmployeeService;
import cn.slkj.taxi.util.DateUtil;
import cn.slkj.taxi.util.EPager;
import cn.slkj.taxi.util.JsonResult;
import cn.slkj.taxi.util.ObjectExcelView;
import cn.slkj.taxi.util.PageData;
import cn.slkj.taxi.util.Tools;

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
@RequestMapping({"/employeeRank"})
public class EmployeeRankController extends BaseController {
	
	@Autowired
	private EmployeeRankService employeeRankService;
	@Autowired
	private EmployeeService employeeService;

	@RequestMapping({ "/listPage" })
	public ModelAndView listPage() throws Exception {
		ModelAndView mv = new ModelAndView();
		try {			
			mv.setViewName("employee_rank/employee_rank_list");			
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
		return mv;
	}
	/*@RequestMapping({ "/checkListPage" })
	public ModelAndView checkListPage(HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("employee_rank/employee_rank_checklist");
		return mv;
	}*/
	
	/**
	 * 查询列表，返回easyUI数据格式
	 */
	/*@ResponseBody
	@RequestMapping(value = "/checkList", method = { RequestMethod.POST })
	public EPager<EmployeeRank> checkList(HttpSession session) {
		PageData pd = getPageData();
		Integer rows = pd.getIntegr("rows");
		Integer page = pd.getIntegr("page");
		String sortString = "ADDTIME.DESC";// 如果你想排序的话逗号分隔可以排序多列		
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<EmployeeRank> list = employeeRankService.list(pd, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<EmployeeRank>(pageList.getPaginator().getTotalCount(), list);
	}*/
	@ResponseBody
	@RequestMapping(value = "/list", method = { RequestMethod.POST })
	public EPager<EmployeeRank> list(HttpSession session) {
		PageData pd = getPageData();
		Integer rows = pd.getIntegr("rows");
		Integer page = pd.getIntegr("page");
		String sortString = "YEAR.DESC";// 如果你想排序的话逗号分隔可以排序多列		
		User user = (User)session.getAttribute("sessionUser");
		  if ((user.getDepartName() != null) && (!"".equals(user.getDepartName()))) {
		        pd.put("company", user.getDepartName());
		      }else{
		    	pd.put("company", "总公司");
		      }
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<EmployeeRank> list = employeeRankService.list(pd, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<EmployeeRank>(pageList.getPaginator().getTotalCount(), list);
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
				hashMap.put("status", "3");
				Employee employee = this.employeeService.selectOne(hashMap);
				mv.addObject("employee", employee);
				
			}
			mv.addObject("msg", "save");
			mv.setViewName("employee_rank/employee_rank_edit");
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
		return mv;
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "/save", method = { RequestMethod.POST })
	public boolean save()  throws Exception{		
		PageData pd = new PageData();
		try {
			pd = getPageData();
			int rti = 0;
			String id = pd.getString("id");
			if (Tools.notEmpty(id)) {
				rti = employeeRankService.update(pd);
			} else {
				//pd.put("id", UuidUtil.get32UUID());
				pd.put("id", (DateUtil.getDayss() + new Random().nextInt()).substring(0, 15).replace("-", ""));
			    pd.put("year", DateUtil.getYear());
				rti = employeeRankService.insert(pd);
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
		int i = employeeRankService.delete(id);
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
	
	@RequestMapping({"/goExcel"})
	  public ModelAndView goExcel(HttpSession session)
	  {
	    ModelAndView mv = getModelAndView();
	    PageData pd = new PageData();
	    pd = getPageData();
	   
	    try {
	    	if ((pd.getString("name") != null) && (!"".equalsIgnoreCase(pd.getString("name").trim()))) {
	    	 String name= URLDecoder.decode(pd.getString("name"), "utf-8");
	    	 pd.put("name", name);
	    	}
	    	
	    	if ((pd.getString("cyzgCard") != null) && (!"".equalsIgnoreCase(pd.getString("cyzgCard").trim()))) {
	    	 String cyzgCard= URLDecoder.decode(pd.getString("cyzgCard"), "utf-8");
	    	 pd.put("cyzgCard", cyzgCard);
	    	}
	    	/*if ((pd.getString("company") != null) && (!"".equalsIgnoreCase(pd.getString("company").trim()))) {
		    	 String company= URLDecoder.decode(pd.getString("company"), "utf-8");
		    	 pd.put("company", company);
		    	}*/
	    	
	    	//权限，是否按公司查询
	    	if ((pd.getString("right") != null) && (!"".equalsIgnoreCase(pd.getString("right").trim()))) {
		    	 String right= URLDecoder.decode(pd.getString("right"), "utf-8");
		    	 if(right.equals("1")){
		    		 User user = (User)session.getAttribute("sessionUser");
		   		  if ((user.getDepartName() != null) && (!"".equals(user.getDepartName()))) {
		   		        pd.put("company", user.getDepartName());
		   		      }else{
		   		    	pd.put("company", "总公司");
		   		      } 
		    	 }
		    	 
		    	}
	    	 
	      Map dataMap = new HashMap();
	      List titles = new ArrayList();

	      titles.add("编号");
	      titles.add("姓名");
	      titles.add("性别");
	      titles.add("出生年月");
	      titles.add("身份证号");
	      titles.add("受教育程度");
	      titles.add("从业资格证号");
	      titles.add("车牌号");
	      titles.add("联系方式");
	      titles.add("公司");
	      titles.add("年份");
	      titles.add("评级");
	      titles.add("添加时间");
	      dataMap.put("titles", titles);

	      List emList = this.employeeRankService.excelList(pd);
	      List varList = new ArrayList();
	      for (int i = 0; i < emList.size(); i++) {
	        PageData vpd = new PageData();
	        vpd.put("var1", ((PageData)emList.get(i)).getString("ID"));
	        vpd.put("var2", ((PageData)emList.get(i)).getString("NAME"));
	        if (((PageData)emList.get(i)).getString("SEX") != null) {
	          if (((PageData)emList.get(i)).getString("SEX").equals("0"))
	            vpd.put("var3", "男");
	          else if (((PageData)emList.get(i)).getString("SEX").equals("1"))
	            vpd.put("var3", "女");
	          else
	            vpd.put("var3", "不详");
	        }
	        else {
	          vpd.put("var3", "不详");
	        }

	        vpd.put("var4", ((PageData)emList.get(i)).getString("BORNDATE"));
	        vpd.put("var5", ((PageData)emList.get(i)).getString("IDCARD"));
	        vpd.put("var6", ((PageData)emList.get(i)).getString("EDUCATED"));
	        vpd.put("var7", ((PageData)emList.get(i)).getString("CYZG_CARD"));
	        vpd.put("var8", ((PageData)emList.get(i)).getString("CARID"));
	        vpd.put("var9", ((PageData)emList.get(i)).getString("PHONE"));
	        vpd.put("var10", ((PageData)emList.get(i)).getString("COMPANY"));
	        vpd.put("var11", ((PageData)emList.get(i)).getString("YEAR"));
	        vpd.put("var12", ((PageData)emList.get(i)).getString("RANK"));
	        vpd.put("var13", ((PageData)emList.get(i)).getString("CREATE_TIME"));
	        varList.add(vpd);
	      }

	      dataMap.put("varList", varList);

	      ObjectExcelView erv = new ObjectExcelView();

	      mv = new ModelAndView(erv, dataMap);
	    } catch (Exception e) {System.out.println(e.toString());
	      this.logger.error(e.toString(), e);
	    }
	    return mv;
	  }
}
