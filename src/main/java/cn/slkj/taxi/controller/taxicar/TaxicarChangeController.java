package cn.slkj.taxi.controller.taxicar;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cn.slkj.taxi.controller.base.BaseController;
import cn.slkj.taxi.entity.Taxicar;
import cn.slkj.taxi.entity.User;
import cn.slkj.taxi.ireport.JasperHelper;
import cn.slkj.taxi.service.TaxicarService;
import cn.slkj.taxi.util.DateUtil;
import cn.slkj.taxi.util.EPager;
import cn.slkj.taxi.util.FileDownload;
import cn.slkj.taxi.util.FileUpload;
import cn.slkj.taxi.util.FileUtil;
import cn.slkj.taxi.util.JsonResult;
import cn.slkj.taxi.util.ObjectExcelRead;
import cn.slkj.taxi.util.ObjectExcelView;
import cn.slkj.taxi.util.PageData;
import cn.slkj.taxi.util.PathUtil;
import cn.slkj.taxi.util.Tools;
import cn.slkj.taxi.util.UuidUtil;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;

@Controller
@RequestMapping(value = "/taxicarChange")
public class TaxicarChangeController extends BaseController {
	@Autowired
	private TaxicarService taxicarService;

	/* 跳转页面 */
	// 变更查询页面
	@RequestMapping("/taxicarChangeListPage")
	public ModelAndView taxicarChangeListPage(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		User user = (User) session.getAttribute("sessionUser");
		if (user.getDepartName().isEmpty() ) {
			mv.addObject("flag", "0");
		} else {
			mv.addObject("flag", "1");
		}
		mv.setViewName("taxi_car_change/taxi_car_change_list");
		return mv;
	}

	// 变更审核页面
	@RequestMapping("/taxicarChangeCheckListPage")
	public String taxicarChangeCheckListPage() {
		return "taxi_car_change/taxi_car_change_check";
	}

	@RequestMapping({ "/goChangeInfo" })
	public ModelAndView goChangeInfo() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = getPageData();
		try {
			Taxicar taxicar = taxicarService.queryOneChange(pd);
			mv.setViewName("taxi_car_change/taxi_car_change_edit");
			mv.addObject("pd", taxicar);
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 查询列表，返回easyUI数据格式
	 */
	@ResponseBody
	@RequestMapping(value = "/list", method = { RequestMethod.POST })
	public EPager<Taxicar> getAllTaxicar(HttpSession session) throws IOException {
		String sortString = "transferDate.DESC";
		PageData pd = new PageData();
		pd = getPageData();
		Integer rows = pd.getIntegr("rows");
		Integer page = pd.getIntegr("page");
		User user = (User) session.getAttribute("sessionUser");
		if ((user.getDepartName() != "超级管理员") && (!"超级管理员".equals(user.getDepartName()))) {
			// pd.put("company", user.getDepartName());
			if ((user.getDepartName() != null) && (!user.getDepartName().trim().equals(""))) {
				pd.put("company", user.getDepartName());
			} else {
				pd.put("company", pd.getString("company"));
			}
		} else {
			pd.put("company", pd.getString("company"));
		}
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<Taxicar> list = taxicarService.getchangeAllList(pd, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<Taxicar>(pageList.getPaginator().getTotalCount(), list);
	}

	@ResponseBody
	@RequestMapping(value = "/change", method = RequestMethod.POST)
	public boolean change() {
		try {
			PageData pd = new PageData();
			pd = getPageData();
			int rti = 0;
			rti = taxicarService.change(pd);
			String id = pd.getString("id");
			String sta = pd.getString("state");
			if (sta.equals("1")) {
				taxicarService.delete(id);
				taxicarService.copyChange(pd);
				taxicarService.deleteChange(id);
			}
			return rti > 0 ? true : false;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
