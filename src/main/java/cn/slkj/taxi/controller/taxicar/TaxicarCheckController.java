package cn.slkj.taxi.controller.taxicar;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.slkj.taxi.controller.base.BaseController;
import cn.slkj.taxi.entity.TaxicarCheck;
import cn.slkj.taxi.service.TaxicarCheckService;
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
 * 
 * @ClassName:  TaxicarCheckController   
 * @Description:年审业务  
 * @author: Administrator 
 * @date:   2018年11月17日 下午3:42:53   
 *
 */
@Controller
@RequestMapping(value = "/taxicarCheck")
public class TaxicarCheckController  extends BaseController{
	@Autowired
	private TaxicarCheckService taxicarCheckService;

	
	/* 跳转页面 */
	@RequestMapping("/taxicarCheckListPage")
	public String toTaxicarCheckListPage() {
		return "taxi_car_check/taxi_car_check_list";
	}
	/* 跳转页面 */
	@RequestMapping("/taxicarTopCheckListPage")
	public String toTaxicarTopCheckListPage() {
		return "taxi_car_check/taxi_car_topcheck_list";
	}

	
	@RequestMapping("/taxicarCheckEditPage")
	public String toTaxicarCheckEditPage() {
		return "taxi_car_check/taxi_car_check_edit";
	}
	@RequestMapping("/taxicarTopCheckCheckPage")
	public String toTaxicarTopCheckCheckPage() {
		return "taxi_car_check/taxi_car_topcheck_check";
	}
	
	/**
	 * 查询列表，返回easyUI数据格式
	 */
	@ResponseBody
	@RequestMapping(value = "/checkList", method = { RequestMethod.POST })
	public EPager<TaxicarCheck> getCheckList() throws IOException {
		String sortString = "ADDTIME.DESC";
		PageData pd = new PageData();
		pd = getPageData();
		Integer rows = pd.getIntegr("rows");
		Integer page = pd.getIntegr("page");
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<TaxicarCheck> list = taxicarCheckService.getCheckList(pd, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<TaxicarCheck>(pageList.getPaginator().getTotalCount(), list);
	}
	
	/**
	 * 查询列表，返回easyUI数据格式
	 */
	@ResponseBody
	@RequestMapping(value = "/topcheckList", method = { RequestMethod.POST })
	public EPager<TaxicarCheck> getTopCheckList() throws IOException {
		String sortString = "ADDTIME.DESC";
		PageData pd = new PageData();
		pd = getPageData();
		Integer rows = pd.getIntegr("rows");
		Integer page = pd.getIntegr("page");
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<TaxicarCheck> list = taxicarCheckService.getOutCheckList(pd, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<TaxicarCheck>(pageList.getPaginator().getTotalCount(), list);
	}

	
	  
	  /**
		 * 查询单条信息
		 */
		@ResponseBody
		@RequestMapping(value = "/queryOneCheck", method = { RequestMethod.POST })
		public TaxicarCheck queryOneCheck() {
			PageData pd = new PageData();
			pd = getPageData();
			TaxicarCheck TaxicarCheck = taxicarCheckService.queryOneCheck(pd);
			return TaxicarCheck;
		}
	  
	  /**
		 * 保存车辆信息
		 * 
		 * @param Taxicar
		 * @return
		 */
		@ResponseBody
		@RequestMapping(value = "/saveCheck", method = RequestMethod.POST)
		public boolean saveCheck() throws Exception {
			try {
				PageData pd = new PageData();
				pd = getPageData();
				int rti = 0;
				String id = pd.getString("id");
				pd.put("addtime", DateUtil.getTime());
				if (Tools.notEmpty(id)) {
					rti = taxicarCheckService.editCheck(pd);
				} else {
					pd.put("id", UuidUtil.get32UUID());
					if (taxicarCheckService.checkDateByOper(pd.getString("operatingnum"))==null) {
						 	  pd.put("status", 0);
				          } else {
				        	  pd.put("status", 1);
				          }
					rti = taxicarCheckService.saveCheck(pd);
				}
				return rti > 0 ? true : false;				
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
			
		}

		
		/** 删除 */
		@ResponseBody
		@RequestMapping(value = "/deleteCheck")
		public JsonResult deleteCheck(String id) {
			int i = taxicarCheckService.deleteCheck(id);
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
		/**
		 * 编辑车辆信息
		 * 
		 * @param Taxicar
		 * @return
		 */
		@ResponseBody
		@RequestMapping(value = "/editCheckStatus", method = RequestMethod.POST)
		public JsonResult editTaxicarCheckStatus() {
			try {
				
				int i = -1;
				PageData pd = new PageData();
				pd = getPageData();
				i = taxicarCheckService.changeStatus(pd);
				if (i != -1) {
					return new JsonResult(true, "操作成功。");
				}
			} catch (Exception e) {
				e.printStackTrace();
				return new JsonResult(false, e.toString());
			}
			return new JsonResult(false, "操作失败！");
		}
	
    
}
