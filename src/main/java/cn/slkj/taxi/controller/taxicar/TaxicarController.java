package cn.slkj.taxi.controller.taxicar;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cn.slkj.taxi.controller.base.BaseController;
import cn.slkj.taxi.entity.ExamineStandard;
import cn.slkj.taxi.entity.Taxicar;
import cn.slkj.taxi.entity.User;
import cn.slkj.taxi.service.TaxicarService;
import cn.slkj.taxi.util.DateUtil;
import cn.slkj.taxi.util.EPager;
import cn.slkj.taxi.util.FileUtil;
import cn.slkj.taxi.util.JsonResult;
import cn.slkj.taxi.util.PageData;
import cn.slkj.taxi.util.Tools;
import cn.slkj.taxi.util.UuidUtil;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;



@Controller
@RequestMapping(value = "/taxicar")
public class TaxicarController extends BaseController{
	@Autowired
	private TaxicarService taxicarService;

	/* 跳转页面 */
	@RequestMapping("/taxicarListPage")
	public String toCarListPage() {
		return "taxi_car/taxi_car_list";
	}

	/**
	 * 查询列表，返回easyUI数据格式
	 */
	@ResponseBody
	@RequestMapping(value = "/list", method = { RequestMethod.POST })
	public EPager<Taxicar> getAllTaxicar(HttpSession session) throws IOException {
		String sortString = "ADDTIME.DESC";
		PageData pd = new PageData();
		pd = getPageData();
		Integer rows = pd.getIntegr("rows");
		Integer page = pd.getIntegr("page");
		 User user = (User)session.getAttribute("sessionUser");
			if ((user.getDepartName() != "超级管理员") && (!"超级管理员".equals(user.getDepartName()))) {
				pd.put("company", user.getDepartName());
		      }else{
		    	  pd.put("company", pd.getString("company"));
		      }	
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<Taxicar> list = taxicarService.getAllList(pd, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<Taxicar>(pageList.getPaginator().getTotalCount(), list);
	}
	
	@RequestMapping({ "/goAdd" })
	public ModelAndView goAdd() {
		ModelAndView mv = new ModelAndView();
		try {
			mv.setViewName("taxi_car/taxi_car_edit");
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
		return mv;
	}
	@RequestMapping({ "/goEdit" })
	public ModelAndView goEdit() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = getPageData();
		try {
			Taxicar taxicar = taxicarService.queryOne(pd);
			mv.setViewName("taxi_car/taxi_car_edit");
			mv.addObject("pd", taxicar);
		} catch (Exception e) {
			this.logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
	 * 查询单条信息
	 */
	@ResponseBody
	@RequestMapping(value = "/queryOne", method = { RequestMethod.POST })
	public Taxicar queryOne() {
		PageData pd = new PageData();
		pd = getPageData();
		Taxicar taxicar = taxicarService.queryOne(pd);
		return taxicar;
	}
	/**
	 * 查询单条信息
	 */
	/*@ResponseBody
	@RequestMapping(value = "/queryOneByOpr", method = { RequestMethod.POST })
	public Taxicar queryOneByOpr(String opretaCertNum) {
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("OpretaCertNum", opretaCertNum);
		Taxicar taxicar = taxicarService.queryOne(hashMap);
		return taxicar;
	}*/
	/**
	 * 保存车辆信息
	 * 
	 * @param taxicar
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public boolean save(@RequestParam(value="ownernamepic1", required=false) MultipartFile ownernamepic1,
			@RequestParam(value="vehiclepic1", required=false) MultipartFile vehiclepic1,
			Taxicar taxicar) {
		try {
			 if ((vehiclepic1 != null) && (!vehiclepic1.isEmpty())) {
				 //pd.put("vehiclePic", FileUtil.toByteArray(vehiclepic1.getInputStream()));
				 taxicar.setVehiclePic(FileUtil.toByteArray(vehiclepic1.getInputStream()));
			 }
			 if ((ownernamepic1 != null) && (!ownernamepic1.isEmpty())) {
				 //pd.put("ownerNamePic", FileUtil.toByteArray(ownernamepic1.getInputStream()));
				 taxicar.setOwnerNamePic(FileUtil.toByteArray(ownernamepic1.getInputStream()));
			 }
			int i = -1;
			taxicar.setaDDTIME(DateUtil.getTime());
			int rti = 0;
			//String id = pd.getString("id");
			String id = taxicar.getId();
			if (Tools.notEmpty(id)) {
				rti = taxicarService.edit(taxicar);
			} else {
				taxicar.setId(UuidUtil.get32UUID());
				rti = taxicarService.save(taxicar);
			}
			return rti > 0 ? true : false;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	

	/** 删除 */
	@ResponseBody
	@RequestMapping(value = "/delete")
	public JsonResult deletes(String id) {
		int i = taxicarService.delete(id);
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
	
	@RequestMapping({"/getVehiclepic"})
	  public void getVehiclepic(HttpServletResponse response)
	    throws IOException
	  {
	    try
	    {
	    	PageData pd = new PageData();
	    	pd = getPageData();
			Taxicar taxicar = taxicarService.queryOne(pd);
	      byte[] data = taxicar.getVehiclePic();
	      response.setContentType("image/jpg");
	      OutputStream stream = response.getOutputStream();
	      stream.write(data);
	      stream.flush();
	      stream.close();
	    } catch (Exception e) {
	    	System.out.println("图片无法显示");
			e.printStackTrace();
	    }
	  }

	  @RequestMapping({"/getOwnernamepic"})
	  public void getOwnernamepic(HttpServletResponse response)
	    throws IOException
	  {
	    try
	    {
	    	PageData pd = new PageData();
	    	pd = getPageData();
			Taxicar taxicar = taxicarService.queryOne(pd);
	      byte[] data = taxicar.getOwnerNamePic();
	      response.setContentType("image/jpg");
	      OutputStream stream = response.getOutputStream();
	      stream.write(data);
	      stream.flush();
	      stream.close();
	    } catch (Exception e) {
	    	System.out.println("图片无法显示");
			e.printStackTrace();
	    }
	  }
	  


	
    
}
