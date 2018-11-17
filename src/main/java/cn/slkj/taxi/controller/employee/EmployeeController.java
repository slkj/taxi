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

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;

import cn.slkj.taxi.controller.base.BaseController;
import cn.slkj.taxi.entity.Employee;
import cn.slkj.taxi.entity.User;
import cn.slkj.taxi.service.EmployeeService;
import cn.slkj.taxi.util.Const;
import cn.slkj.taxi.util.DateUtil;
import cn.slkj.taxi.util.EPager;
import cn.slkj.taxi.util.FileUtil;
import cn.slkj.taxi.util.PageData;
import cn.slkj.taxi.util.UuidUtil;

/**
 * 
 * 从业人员管理
 * 
 * @author maxuh
 *
 */

@Controller
@RequestMapping({ "/employee" })
public class EmployeeController extends BaseController {
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
			// List<Company> enterpriseInfo = companyService.queryComList(hashMapCom);
			mv.setViewName("employee/employee_edit");
			// mv.addObject("enterpriseInfo", enterpriseInfo);
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
			// List<Company> enterpriseInfo = companyService.queryComList(hashMapCom);
			mv.setViewName("employee/employee_edit");
			// mv.addObject("enterpriseInfo", enterpriseInfo);
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
	public EPager<Employee> employeeList(HttpSession session) {
		PageData pd = new PageData();
		pd = getPageData();
		Integer rows = pd.getIntegr("rows");
		Integer page = pd.getIntegr("page");
		String sortString = "ADDTIME.DESC,PERSONAL_ID.ASC,";// 如果你想排序的话逗号分隔可以排序多列
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("name", pd.getString("name"));
		hashMap.put("status", pd.getString("status"));
		hashMap.put("company", pd.getString("company"));
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<Employee> list = employeeService.listPage(hashMap, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<Employee>(pageList.getPaginator().getTotalCount(), list);
	}

	@ResponseBody
	@RequestMapping({ "/delete" })
	public boolean delete() throws Exception {
		PageData pd = getPageData();
		int rti = employeeService.deleteById(pd.getString("id"));
		return rti > 0 ? true : false;
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

	@RequestMapping({ "/goSignUpAdd" })
	public ModelAndView goSignUpAdd(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = getPageData();
		try {
			// User user = (User) session.getAttribute("USERROL");
			// List<EnterpriseInfo> enterpriseInfo =
			// this.enterpriseInfoService.listAllEnt();
			mv.addObject("pd", pd);
			mv.setViewName("signup/signup_edit");
			// mv.addObject("enterpriseInfo", enterpriseInfo);
			mv.addObject("msg", "save");
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 查询列表，返回easyUI数据格式
	 */
	@ResponseBody
	@RequestMapping(value = "/slistPage", method = { RequestMethod.POST })
	public EPager<Employee> slistPage(HttpSession session) {
		PageData pd = new PageData();
		pd = getPageData();
		Integer rows = pd.getIntegr("rows");
		Integer page = pd.getIntegr("page");
		String sortString = "ADDTIME.DESC";// 如果你想排序的话逗号分隔可以排序多列
		User user = (User) session.getAttribute(Const.SESSION_USER);
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("company", user.getDepartName());
		hashMap.put("name", pd.getString("name"));
		hashMap.put("status", pd.getString("status"));
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<Employee> list = employeeService.slistPage(hashMap, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<Employee>(pageList.getPaginator().getTotalCount(), list);
	}

	@ResponseBody
	@RequestMapping({ "/save" })
	public boolean save(HttpServletRequest request, @RequestParam(value = "photo", required = false) MultipartFile photo,
			@RequestParam(value = "personalId", required = false) String personalId, @RequestParam(value = "permitFilesId", required = false) String permitFilesId,
			@RequestParam(value = "name", required = false) String name, @RequestParam(value = "sex", required = false) String sex,
			@RequestParam(value = "borndate", required = false) String borndate, @RequestParam(value = "nationality", required = false) String nationality,
			@RequestParam(value = "idcard", required = false) String idcard, @RequestParam(value = "educated", required = false) String educated,
			@RequestParam(value = "phone", required = false) String phone, @RequestParam(value = "address", required = false) String address,
			@RequestParam(value = "driveCard", required = false) String driveCard, @RequestParam(value = "driveStartDate", required = false) String driveStartDate,
			@RequestParam(value = "driveType", required = false) String driveType, @RequestParam(value = "cyzgCard", required = false) String cyzgCard,
			@RequestParam(value = "registerDate", required = false) String registerDate, @RequestParam(value = "cancelDate", required = false) String cancelDate,
			@RequestParam(value = "fwzljdCard", required = false) String fwzljdCard, @RequestParam(value = "fwzljdRepairDate", required = false) String fwzljdRepairDate,
			@RequestParam(value = "carid", required = false) String carid, @RequestParam(value = "cartype", required = false) String cartype,
			@RequestParam(value = "company", required = false) String company, @RequestParam(value = "oldCompany", required = false) String oldCompany,
			@RequestParam(value = "engageConn", required = false) String engageConn, @RequestParam(value = "engageTime", required = false) String engageTime,
			@RequestParam(value = "contractSrtCount", required = false) String contractSrtCount,
			@RequestParam(value = "contractEndCount", required = false) String contractEndCount, @RequestParam(value = "contractCount", required = false) String contractCount,
			@RequestParam(value = "infoPages", required = false) Integer infoPages, @RequestParam(value = "examPages", required = false) Integer examPages,
			@RequestParam(value = "sfhz", required = false) String sfhz, @RequestParam(value = "expReg", required = false) String expReg,
			@RequestParam(value = "reCyzgDate", required = false) String reCyzgDate, @RequestParam(value = "shzt", required = false) String shzt,
			@RequestParam(value = "decisionHours", required = false) String decisionHours, @RequestParam(value = "approvalHours", required = false) String approvalHours,
			@RequestParam(value = "status", required = false) String status) throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = getPageData();
		int rti = 0;
		String id = UuidUtil.get32UUID();
		pd.put("id", id);
		pd.put("personalId", personalId);
		pd.put("permitFilesId", permitFilesId);
		pd.put("name", name);
		pd.put("sex", sex);
		pd.put("borndate", borndate);
		pd.put("nationality", nationality);
		pd.put("idcard", idcard);
		pd.put("educated", educated);
		pd.put("phone", phone);
		pd.put("address", address);
		pd.put("driveCard", driveCard);
		pd.put("driveStartDate", driveStartDate);
		pd.put("driveType", driveType);
		pd.put("cyzgCard", cyzgCard);
		pd.put("registerDate", registerDate);
		pd.put("cancelDate", cancelDate);
		pd.put("fwzljdCard", fwzljdCard);
		pd.put("fwzljdRepairDate", fwzljdRepairDate);
		pd.put("carid", carid);
		pd.put("cartype", cartype);
		pd.put("company", company);
		pd.put("oldCompany", oldCompany);
		pd.put("engageConn", engageConn);
		pd.put("engageTime", engageTime);
		pd.put("contractSrtCount", contractSrtCount);
		pd.put("contractEndCount", contractEndCount);
		pd.put("contractCount", contractCount);
		pd.put("infoPages", infoPages);
		pd.put("examPages", examPages);
		pd.put("sfhz", sfhz);
		pd.put("expReg", expReg);
		pd.put("reCyzgDate", reCyzgDate);
		pd.put("shzt", shzt);
		pd.put("decisionHours", decisionHours);
		pd.put("approvalHours", approvalHours);

		pd.put("status", status);

		pd.put("addtime", DateUtil.getTime());

		if ((photo != null) && (!photo.isEmpty())) {
			byte[] byteArryPhoto = FileUtil.toByteArray(photo.getInputStream());
			pd.put("photo", byteArryPhoto);
		}
		rti = employeeService.insertSelective(pd);
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return rti > 0 ? true : false;
		// return mv;
	}

	@RequestMapping({ "/goSignUpEdit" })
	public ModelAndView goSignUpEdit() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = getPageData();
		try {
			HashMap<String, Object> hashMap = new HashMap<String, Object>();
			hashMap.put("id", pd.getString("id"));
			Employee ep = this.employeeService.selectOne(hashMap);
			// List<EnterpriseInfo> enterpriseInfo =
			// this.enterpriseInfoService.listAllEnt();
			mv.setViewName("signup/signup_edit");
			// mv.addObject("enterpriseInfo", enterpriseInfo);
			mv.addObject("msg", "edit");
			mv.addObject("pd", ep);
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 读取照片 @Title: getOwnernamepic @Description:
	 * TODO(这里用一句话描述这个方法的作用) @param: @param id @param: @param request @param: @param
	 * response @param: @throws IOException @return: void @throws
	 */
	@RequestMapping({ "/getPhoto" })
	public void getOwnernamepic(String id, HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			HashMap<String, Object> hashMap = new HashMap<String, Object>();
			hashMap.put("id", id);
			Employee employee = this.employeeService.selectOne(hashMap);
			byte[] data = employee.getPhoto();
			response.setContentType("image/jpg");
			OutputStream stream = response.getOutputStream();
			stream.write(data);
			stream.flush();
			stream.close();
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
	}

	@RequestMapping({ "/goExamResult" })
	public ModelAndView goExamResult() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = getPageData();
		try {
			if ((pd.getString("idcard") != null) && (!"".equalsIgnoreCase(pd.getString("idcard").trim()))) {
				HashMap<String, Object> hashMap = new HashMap<String, Object>();
				hashMap.put("idcard", pd.getString("idcard"));
				Employee employee = this.employeeService.selectOne(hashMap);
				mv.addObject("employee", employee);
			}
			mv.addObject("pd", pd);
			mv.setViewName("exam_results/exam_results_list");
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
		return mv;
	}

	@RequestMapping({ "/changeStatus" })
	public void changeStatus(PrintWriter out) {
		PageData pd = new PageData();
		try {
			pd = getPageData();
			if ((pd.getString("id") != null) && (!"".equals(pd.getString("id")))) {
//				this.employeeService.updateByPrimaryKeySelective(pd);
				out.write("ok");
			} else {
				out.write("no");
			}
			out.close();
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
	}
}
