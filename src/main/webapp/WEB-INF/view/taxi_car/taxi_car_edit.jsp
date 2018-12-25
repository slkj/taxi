<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>考试报名</title>
<%@ include file="/common/taglibs.jsp"%>
<script src="${pageContext.request.contextPath}/assets/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/My97DatePicker/skin/WdatePicker.css">
<script type="text/javascript">
	$(function() {
	$('#corpName').combobox({
		url : '../enterprise/queryEnterpriseList',
		valueField : 'unitname',
		textField : 'unitname',
		onSelect : function(data) {
			$("#corpName").textbox('setValue', data.unitname);
		}
	});
	});
	function submitForm(){//保存提交 
			//校验
			var validate = $("#vui_sample").form('validate');
			if (!validate) {
				return validate;
			}
			var formData=new FormData(document.getElementById("vui_sample"));
			$.ajax({
				type : "POST",
				url : "../taxicar/save",
				data : formData,
				async : false,
	            cache: false,
	            contentType: false,
	            processData: false,
				success : function(data) {
					if (data) {
						//$grid.datagrid('reload');// 刷新datagrid						
						//layer.close(layer.index); 	
						//location.reload(true);	
						var index = parent.layer.getFrameIndex(window.name);
						parent.layer.close(index);
						parent.$('#list_data').datagrid('reload');
					} else {
						msgShow('系统提示', '出现异常');
					}
				}
			});
		}
	function clearForm() {//重置表单
		$('#vui_sample').form('clear');
	}
</script>
</head>
<body>
	
	
			<form id="vui_sample" class="easyui-form" method="post" data-options="novalidate:true">
			<input type="hidden" name="id" value="${pd.id }">
				<table style="table-layout: fixed;" id="table_report" border="1"  class="table table-striped table-bordered table-hover">
		<tr>
			  <td colspan="3"><span
				style="margin-left: 20px;">档案号：</span> <span
				style="margin-left: 2px;"><input class="easyui-textbox" name="fileNum" value="${pd.fileNum }" type="text" style="width: 130px;" /></span></td>
			<td colspan="3"><span
				style="margin-left: 20px;">车主姓名：</span> <span
				style="margin-left: 2px;"><input class="easyui-textbox" name="ownerName" value="${pd.ownerName }" type="text" style="width: 120px;" /></span></td>
			<td colspan="2"><%-- <span
				style="margin-left: 20px;">颜色：</span> <span
				style="margin-left: 2px;"><input class="easyui-textbox" name="color" value="${pd.color }" type="text" style="width: 60px;" /></span> --%>
				<span style="margin-left: 20px;">性别：</span>
					<span style="margin-left: 2px;">
						<select  class="easyui-combobox" style="width: 80px;" id="ownerSex" name="ownerSex" title="性别">
							<option value='0' <c:if test="${pd.ownerSex == '0' }">selected</c:if>>男</option>
							<option value='1' <c:if test="${pd.ownerSex == '1' }">selected</c:if>>女</option>
						</select>
					</span></td>
			<td colspan="3" style="width: 150px;" rowspan="5">
				<div style="width: 125px; height: 155px; margin: 2px;">
					<img id="uploadPreviewOwnerNamePic" style="width: 125px; height: 155px;" src="../taxicar/getOwnernamepic?id=${pd.id}"/>
					<div style="text-align: center;">
	         			<a href="javascript:;" class="a-upload" style="margin-top: 5px;">
					    	<input id="ownernamepic1" name="ownernamepic1"  type="file"  onchange="loadImageFileOwnerNamePic();"/>上传车主照片
						</a>
	         		</div>
				</div>
			</td>
          </tr>
          <tr>
			 <td colspan="3">
              <span style="margin-left:20px;">营运证号：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="opretaCertNum" value="${pd.opretaCertNum }" type="text" style="width: 115px;" /></span>
            </td>
            <td colspan="3">
              <span style="margin-left:20px;">原车主：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="origOwnerName" value="${pd.origOwnerName }" type="text" style="width: 135px;" /></span>
            </td>
            <td colspan="2">
            <span style="margin-left:20px;">车型：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="sign" value="${pd.sign }" type="text" style="width: 80px;" /></span>
                   
            </td>
          </tr>
          <tr>
            <td colspan="3">
              <span style="margin-left:4px;">公司名称：</span>
                    <span style="margin-left:2px;"><input id="corpName" name="corpName" value="${pd.corpName }" type="text" style="width: 180px;" /></span>
            </td>
            <td colspan="3">
              <span style="margin-left:20px;">联系电话：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="phoneNum" value="${pd.phoneNum }" type="text" style="width: 120px;" /></span>
            </td>
            <td colspan="2">
              <span
				style="margin-left: 20px;">车身颜色：</span> <span
				style="margin-left: 2px;"><input class="easyui-textbox" name="color" value="${pd.color }" type="text" style="width: 60px;" /></span>
            </td>
          </tr>
          <tr>
            <td colspan="8">
              <span style="margin-left:20px;">变更日期：</span>
                    <span style="margin-left:2px;"><input class="Wdate" name="transferDate" value="${pd.transferDate }"  style="width: 120px;" 
				onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"/></span>
              <span style="margin-left:20px;">变更记录：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="ownerChange" value="${pd.ownerChange }" type="text" style="width: 180px;" /></span>
              <span style="margin-left:20px;">查封记录：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="sealRecord" value="${pd.sealRecord }" type="text" style="width: 180px;" /></span>
            </td>
          </tr>
          <tr>
            <td colspan="8">
              <span style="margin-left:20px;">车牌号：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="plateNum" value="${pd.plateNum }" type="text" style="width: 100px;" /></span>
              <span style="margin-left:20px;">原车号：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="origPlateNum" value="${pd.origPlateNum }" type="text" style="width: 100px;" /></span>
              <span style="margin-left:20px;">行驶证初次登记：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="drvLicenseDate" value="${pd.drvLicenseDate }" type="text" style="width: 180px;" /></span>
            </td>
          </tr>
          <tr>
			<td colspan="4"><span
				style="margin-left: 20px;">身份证号：</span> <span
				style="margin-left: 2px;"><input class="easyui-textbox" name="iDNumber" value="${pd.iDNumber }" type="text" style="width: 250px;" /></span></td>
			<td colspan="3"> <span style="margin-left: 20px;">车辆所属地区：</span>
					<span style="margin-left: 2px;">
						<select  class="easyui-combobox" style="width: 120px;" id="area" name="area" value="${pd.area }">
							<option value=''></option>
							<option value='市区'>市区</option>
							<option value='双滦'>双滦</option>
							<option value='双滦代管'>双滦代管</option>
						</select>
					</span></td>
			<td colspan="4" style="width: 202px;" rowspan="4">
				<div style="width: 185px; height: 110px; margin: 2px;margin-left: 15px;">
						<img id="uploadPreviewVehiclePic" style="width: 185px; height: 110px;"  src="../taxicar/getVehiclepic?id=${pd.id}"/>
					
					<div style="text-align: center;">
	         			<a href="javascript:;" class="a-upload" style="margin-top: 3px;width: 150px;" >
					    	<input id="vehiclepic1" name="vehiclepic1"  type="file"  onchange="loadImageFileVehiclepic();"/>上传车身照片
						</a>
	         		</div>
				</div>
			</td>
          </tr>
          <tr>
            <td colspan="7">
              <span style="margin-left:20px;">家庭住址：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="address" value="${pd.address }" type="text" style="width: 450px;" /></span>
            </td>
          </tr>
          <tr>
          	<td colspan="7">
              <span style="margin-left:20px;">吨（座）位：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="tonsSeat" value="${pd.tonsSeat }" type="text" style="width: 60px;" /></span>
              <span style="margin-left:20px;">长：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="carLen" value="${pd.carLen }" style="width:60px;" type="text"></span>
              <span style="margin-left:20px;">宽：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="carWidth" value="${pd.carWidth }" style="width:60px;" type="text"></span>
              <span style="margin-left:20px;">高：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="carHigh" value="${pd.carHigh }" style="width:60px;" type="text"></span>
            </td>
          </tr>
          <tr>
          	<td colspan="7">
              <span style="margin-left:20px;">车架号：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="frameNumber" value="${pd.frameNumber }" style="width:270px;" type="text"></span>
            </td>
            
          </tr>
          <tr>
          <td colspan="6">
              <span style="margin-left:20px;">发动机号：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="engineNumber" value="${pd.engineNumber }" style="width:270px;" type="text"></span>
            </td>
          	<td colspan="5">
              <span style="margin-left:20px;">发证日期：</span>
                    <span style="margin-left:2px;"><input  class="Wdate" name="checkDate" value="${pd.checkDate }" style="width: 200px;" 
				onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"/></span>
            </td>
          </tr>
          <tr>
          	<td colspan="11">
              <span style="margin-left:20px;">车辆审验记录：</span>
                    <span style="margin-left:2px;">
                    	<input class="easyui-textbox" name="vehicleInspRec"  value="${pd.vehicleInspRec }"type="text" style="width: 665px;height:60px;"  multiline="true"/>
                    </span>
            </td>
          </tr>
		
          <tr>
			<td style="text-align: center;" colspan="10">
				<input type="submit" name="" value="保存" class="easyui-linkbutton btnPrimary" onclick="submitForm()" style="width: 80px" />
					<input type="submit" name="" value="重置" class="easyui-linkbutton btnDefault" onclick="clearForm()" style="width: 80px" />
			</td>
		  </tr>

		</table>
				
			</form>
	
		<script type="text/javascript">
			 oFReaderOwnerNamePic = new FileReader(), rFilter = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i;
			oFReaderVehiclepic = new FileReader(), rFilter = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i;
			
			oFReaderOwnerNamePic.onload = function (oFREvent) {
			  document.getElementById("uploadPreviewOwnerNamePic").src = oFREvent.target.result;
			};
			oFReaderVehiclepic.onload = function (oFREvent) {
			  document.getElementById("uploadPreviewVehiclePic").src = oFREvent.target.result;
			}; 
			
			function loadImageFileOwnerNamePic() {
			  if (document.getElementById("ownernamepic1").files.length == 0 ){return; }
			  var oFile = document.getElementById("ownernamepic1").files[0];
			  if (!rFilter.test(oFile.type)) { alert("上传图片类型不符!"); return; }
			  oFReaderOwnerNamePic.readAsDataURL(oFile);
			}
			function loadImageFileVehiclepic() {
			  if (document.getElementById("vehiclepic1").files.length == 0 ){return; }
			  var oFile1 = document.getElementById("vehiclepic1").files[0];
			  if (!rFilter.test(oFile1.type)) { alert("上传图片类型不符!"); return; }
			  oFReaderVehiclepic.readAsDataURL(oFile1);
			}
			function closeImageFileVehiclepic(){
				oFReaderVehiclepic.close();
			}
		</script>
</body>
</html>