package cn.slkj.taxi.controller.enterprise;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.slkj.taxi.controller.base.BaseController;
import cn.slkj.taxi.entity.EnterpriseEval;
import cn.slkj.taxi.service.EnterpriseEvalService;
import cn.slkj.taxi.util.EPager;
import cn.slkj.taxi.util.JsonResult;
import cn.slkj.taxi.util.PageData;
import cn.slkj.taxi.util.Tools;
import cn.slkj.taxi.util.UuidUtil;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;


@Controller
@RequestMapping(value = "/enterpriseEval")
public class EnterpriseEvalController  extends BaseController{

	@Autowired
	private EnterpriseEvalService enterpriseEvalService;

	/* 跳转页面 */
	@RequestMapping("/enterpriseEvalListPage")
	public String enterpriseEvalListPage() {
		return "enterprise_eval/enterprise_eval_list";
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
	public EPager<EnterpriseEval> list() throws IOException{		
		PageData pd = new PageData();
		pd = getPageData();
		Integer rows = pd.getIntegr("rows");
		Integer page = pd.getIntegr("page");
		String sortString = "ADDTIME.DESC";
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<EnterpriseEval> list = enterpriseEvalService.getAll(pd, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<EnterpriseEval>(pageList.getPaginator().getTotalCount(), list);
	}
	

	/**
	 * 获取公司/车队实体
	 * 
	 * @param classification
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/queryOne")
	public EnterpriseEval queryOne(String id) {
		return enterpriseEvalService.queryOne(id);
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
				rti = enterpriseEvalService.edit(pd);
			} else {
				pd.put("id", UuidUtil.get32UUID());
				rti = enterpriseEvalService.save(pd);
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
		int i = enterpriseEvalService.delete(id);
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
