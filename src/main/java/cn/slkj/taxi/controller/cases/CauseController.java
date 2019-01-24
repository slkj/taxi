package cn.slkj.taxi.controller.cases;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.slkj.taxi.controller.base.BaseController;
import cn.slkj.taxi.service.CaseService;
import cn.slkj.taxi.util.PageData;

@Controller
@RequestMapping({ "/case" })
public class CauseController extends BaseController {
	@Autowired
	private CaseService caseService;

	@RequestMapping({ "/cause/listPage" })
	public ModelAndView list() {
		ModelAndView mv = new ModelAndView();
		// PageData pd = new PageData();
		// pd = getPageData();
		// List<PageData> list1 = this.caseService.list(pd);
		// mv.addObject("varList", list1);
		mv.setViewName("cause/cause_list");
		return mv;
	}

	@RequestMapping({ "/cause/xyAddView" })
	public ModelAndView xyAddView() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = getPageData();
		PageData jbxx = this.caseService.listJbxx(pd);
		System.out.println(jbxx);
		mv.addObject("jbxx", jbxx);
		mv.setViewName("cause/case_add_xywz");

		return mv;
	}

	@ResponseBody
	@RequestMapping({ "/cause/listData" })
	public List<PageData> listData() throws IOException {
		PageData pd = new PageData();
		pd = getPageData();
		return this.caseService.list(pd);
	}
}
