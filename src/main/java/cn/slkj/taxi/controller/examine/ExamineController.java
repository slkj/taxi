/**
 * 
 */
package cn.slkj.taxi.controller.examine;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.taxi.controller.base.BaseController;
import cn.slkj.taxi.entity.Employee;
import cn.slkj.taxi.entity.Examine;
import cn.slkj.taxi.entity.ExamineStandard;
import cn.slkj.taxi.service.EmployeeService;
import cn.slkj.taxi.service.ExamineService;
import cn.slkj.taxi.util.PageData;

/**
 * 
 * 诚信考核
 * 
 * @author maxuh
 *
 */

@Controller
@RequestMapping({ "/examine" })
public class ExamineController extends BaseController {

	@Autowired
	private ExamineService examineService;
	@Autowired
	private EmployeeService employeeService;

	@RequestMapping("/examineAdd")
	public ModelAndView examineAdd() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = getPageData();
		try {
			if ((pd.getString("idcard") != null) && (!"".equalsIgnoreCase(pd.getString("idcard").trim()))) {
				HashMap<String, Object> hashMap = new HashMap<String, Object>();
				hashMap.put("idcard", pd.getString("idcard"));
				Employee employee = this.employeeService.selectOne(hashMap);
				mv.addObject("employee", employee);
				
				Integer rows = 100;
				Integer page = 0;
				String sortString = "";// 如果你想排序的话逗号分隔可以排序多列
				HashMap<String, Object> map = new HashMap<String, Object>();
				PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
				List<Examine> list = examineService.getExamineList(map, pageBounds);
				
				int fractionTotal = 100;
				int syFraction=0;
				for (int i = 0; i < list.size(); i++) {
					Examine e = list.get(i);
					syFraction = fractionTotal - e.getScoring();
				}
				//剩余分数
				mv.addObject("syFraction", syFraction);
				
				
				mv.addObject("staList", list);
			}
			mv.addObject("pd", pd);
			mv.setViewName("examine/examineAdd");
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
		return mv;
	}

	@RequestMapping("/standard")
	public ModelAndView standardView() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = getPageData();
		try {
			List<ExamineStandard> list = examineService.getStandardList();
			mv.addObject("standardList",list);
			mv.addObject("pd", pd);
			mv.setViewName("examine/standard");
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
		return mv;
	}
}
