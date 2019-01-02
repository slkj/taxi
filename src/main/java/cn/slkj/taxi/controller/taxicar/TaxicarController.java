package cn.slkj.taxi.controller.taxicar;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import cn.slkj.taxi.util.ObjectExcelView;
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
	  

	  @RequestMapping({"/goExcel"})
	  public ModelAndView goExcel(HttpSession session)
	  {
	    ModelAndView mv = getModelAndView();
	    PageData pd = new PageData();
	    pd = getPageData();
	   
	    try {
	    	if ((pd.getString("PlateNum") != null) && (!"".equalsIgnoreCase(pd.getString("PlateNum").trim()))) {
	    	 String PlateNum= URLDecoder.decode(pd.getString("PlateNum"), "utf-8");
	    	 pd.put("PlateNum", PlateNum);
	    	}
	    	if ((pd.getString("OpretaCertNum") != null) && (!"".equalsIgnoreCase(pd.getString("OpretaCertNum").trim()))) {
		    	 String OpretaCertNum= URLDecoder.decode(pd.getString("OpretaCertNum"), "utf-8");
		    	 pd.put("OpretaCertNum", OpretaCertNum);
		    	}
	    	if ((pd.getString("OwnerName") != null) && (!"".equalsIgnoreCase(pd.getString("OwnerName").trim()))) {
		    	 String OwnerName= URLDecoder.decode(pd.getString("OwnerName"), "utf-8");
		    	 pd.put("OwnerName", OwnerName);
		    	}
	    	if ((pd.getString("Area") != null) && (!"".equalsIgnoreCase(pd.getString("Area").trim()))) {
		    	 String Area= URLDecoder.decode(pd.getString("Area"), "utf-8");
		    	 pd.put("Area", Area);
		    	}
	    	User user = (User)session.getAttribute("sessionUser");
			if ((user.getDepartName() != "超级管理员") && (!"超级管理员".equals(user.getDepartName()))) {
				pd.put("company", user.getDepartName());
		      }else{
		    	  if ((pd.getString("company") != null) && (!"".equalsIgnoreCase(pd.getString("company").trim()))) {
		 	    	 String company= URLDecoder.decode(pd.getString("company"), "utf-8");
		 	    	 pd.put("company", company);
		 	    	}		    	 
		      }
			
	      Map dataMap = new HashMap();
	      List titles = new ArrayList();

	      titles.add("编号");
	      titles.add("档案号");
	      titles.add("营运证号");
	      titles.add("车牌号");
	      titles.add("公司名称");
	      titles.add("车主姓名");
	      titles.add("车主性别");
	      titles.add("所属地区");
	      titles.add("原车主");
	      titles.add("原车牌号");
	      titles.add("操作人员");
	      titles.add("颜色");
	      titles.add("车型");
	      titles.add("查封记录");
	      titles.add("家庭住址");
	      titles.add("联系电话");
	      titles.add("身份证号");
	      titles.add("变更记录");
	      titles.add("行驶证初次登记");
	      titles.add("车辆审验记录");
	      titles.add("吨位");
	      titles.add("长");
	      titles.add("宽");
	      titles.add("高");
	      titles.add("车架号");
	      titles.add("发动机号");
	      titles.add("操作日期");
	      titles.add("发证日期");
	      titles.add("变更日期");	      
	      dataMap.put("titles", titles);

	      List emList = this.taxicarService.excelList(pd);
	      List varList = new ArrayList();
	      for (int i = 0; i < emList.size(); i++) {
	        PageData vpd = new PageData();
	        vpd.put("var1", ((PageData)emList.get(i)).getString("ID"));
	        vpd.put("var2", ((PageData)emList.get(i)).getString("FileNum"));
	        vpd.put("var3", ((PageData)emList.get(i)).getString("OpretaCertNum"));
	        vpd.put("var4", ((PageData)emList.get(i)).getString("PlateNum"));
	        vpd.put("var5", ((PageData)emList.get(i)).getString("CorpName"));
	        vpd.put("var6", ((PageData)emList.get(i)).getString("OwnerName"));
	        //vpd.put("var7", ((PageData)emList.get(i)).getString("OwnerSex"));
	        if (((PageData)emList.get(i)).getString("OwnerSex") != null) {
		          if (((PageData)emList.get(i)).getString("OwnerSex").equals("0"))
		            vpd.put("var7", "男");
		          else if (((PageData)emList.get(i)).getString("OwnerSex").equals("1"))
		            vpd.put("var7", "女");
		          else
		            vpd.put("var7", "不详");
		        }
		        else {
		          vpd.put("var7", "不详");
		        }
	        //vpd.put("var8", ((PageData)emList.get(i)).getString("Area"));
	        if (((PageData)emList.get(i)).getString("Area") != null) {
		          if (((PageData)emList.get(i)).getString("Area").equals("0"))
		            vpd.put("var8", "市区");
		          else if (((PageData)emList.get(i)).getString("Area").equals("1"))
		            vpd.put("var8", "双滦");
		          else if (((PageData)emList.get(i)).getString("Area").equals("2"))
			            vpd.put("var8", "双滦代管");
		          else
		            vpd.put("var8", "不详");
		        }
		        else {
		          vpd.put("var8", "不详");
		        }
	        vpd.put("var9", ((PageData)emList.get(i)).getString("OrigOwnerName"));
	        vpd.put("var10", ((PageData)emList.get(i)).getString("OrigPlateNum"));
	        vpd.put("var11", ((PageData)emList.get(i)).getString("EmployPerson"));
	        vpd.put("var12", ((PageData)emList.get(i)).getString("Color"));
	        vpd.put("var13", ((PageData)emList.get(i)).getString("Sign"));
	        vpd.put("var14", ((PageData)emList.get(i)).getString("SealRecord"));
	        vpd.put("var15", ((PageData)emList.get(i)).getString("Address"));
	        vpd.put("var16", ((PageData)emList.get(i)).getString("PhoneNum"));
	        vpd.put("var17", ((PageData)emList.get(i)).getString("IDNumber"));
	        vpd.put("var18", ((PageData)emList.get(i)).getString("OwnerChange"));
	        vpd.put("var19", ((PageData)emList.get(i)).getString("DrvLicenseDate"));
	        vpd.put("var20", ((PageData)emList.get(i)).getString("VehicleInspRec"));
	        vpd.put("var21", ((PageData)emList.get(i)).getString("TonsSeat"));
	        vpd.put("var22", ((PageData)emList.get(i)).getString("CarLen"));
	        vpd.put("var23", ((PageData)emList.get(i)).getString("CarWidth"));
	        vpd.put("var24", ((PageData)emList.get(i)).getString("CarHigh"));
	        vpd.put("var25", ((PageData)emList.get(i)).getString("FrameNumber"));
	        vpd.put("var26", ((PageData)emList.get(i)).getString("EngineNumber"));
	        vpd.put("var27", ((PageData)emList.get(i)).getString("ADDTIME"));
	        vpd.put("var28", ((PageData)emList.get(i)).getString("CheckDate"));
	        vpd.put("var29", ((PageData)emList.get(i)).getString("TransferDate"));
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
