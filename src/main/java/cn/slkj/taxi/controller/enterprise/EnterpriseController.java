package cn.slkj.taxi.controller.enterprise;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.slkj.taxi.controller.base.BaseController;
import cn.slkj.taxi.entity.Enterprise;
import cn.slkj.taxi.service.EnterpriseService;
import cn.slkj.taxi.util.EPager;
import cn.slkj.taxi.util.JsonResult;
import cn.slkj.taxi.util.PageData;
import cn.slkj.taxi.util.Tools;
import cn.slkj.taxi.util.UuidUtil;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;


@Controller
@RequestMapping(value = "/enterprise")
public class EnterpriseController  extends BaseController{

	@Autowired
	private EnterpriseService enterpriseService;

	/* 跳转页面 */
	@RequestMapping("/enterpriseListPage")
	public String enterpriseListPage() {
		return "enterprise/enterprise_list";
	}
	
	
	
	/**
	 * 
	 * @param page
	 * @param rows
	 * @param gsmc
	 * @param location
	 * @param session
	 * @return 返回easyUI datagrid 数据格式
	 */
	@ResponseBody
	@RequestMapping(value = "/list")
	public EPager<Enterprise> list() throws IOException{		
		PageData pd = new PageData();
		pd = getPageData();
		Integer rows = pd.getIntegr("rows");
		Integer page = pd.getIntegr("page");
		String sortString = "ADDTIME.DESC";
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<Enterprise> list = enterpriseService.getAll(pd, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<Enterprise>(pageList.getPaginator().getTotalCount(), list);
	}
	/**
	 * 
	 * @Title: queryEnterpriseList   
	 * @Description: 获取公司combobox
	 * @param: @param name
	 * @param: @return      
	 * @return: List<Enterprise>      
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/queryEnterpriseList")
	public List<Enterprise> queryEnterpriseList() {
		PageData pd = new PageData();
		pd = getPageData();
		return enterpriseService.queryComList(pd);
	}

	/**
	 * 获取公司/车队实体
	 * 
	 * @param classification
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/queryOne")
	public Enterprise queryOne(String id) {
		return enterpriseService.queryOne(id);
	}
	/**
	 * 
	 * @Title: save   
	 * @Description: 保存 
	 * @param: @param enterprise
	 * @param: @return      
	 * @return: JsonResult      
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = { RequestMethod.POST })
	public boolean save()  throws Exception{
		
		PageData pd = new PageData();
		try {
			pd = getPageData();
			int rti = 0;
			String id = pd.getString("id");
			if (Tools.notEmpty(id)) {
				rti = enterpriseService.edit(pd);
			} else {
				pd.put("id", UuidUtil.get32UUID());
				rti = enterpriseService.save(pd);
			}
			return rti > 0 ? true : false;
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
			return false;
		}
	}
	

	/** 批量删除 */
	@ResponseBody
	@RequestMapping(value = "/delete")
	public JsonResult deletes(String id) {
		int i = enterpriseService.delete(id);
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
}
