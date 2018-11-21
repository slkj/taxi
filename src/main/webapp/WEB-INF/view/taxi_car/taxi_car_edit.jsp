<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/common/taglibs.jsp"%>
<script src="${pageContext.request.contextPath}/assets/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/My97DatePicker/skin/WdatePicker.css">
<script type="text/javascript">
	var $form;
	var pkey;
	var mode;
	var upUrl = getContextPath() + '/taxicar/save';
	var imageUploadDialog;
	var carOwnerPhotoFilePath; //车主照片 文件路径
	var carPhotoFilePath; //车辆照片 文件路径
	var certificatePhotoFilePath; //车辆合格证照片路径
	var certificatePhoto2FilePath; //车辆合格证2照片路径
	var driverPhotoFilePath; //行驶证照片路径
	var comCode;
	$(function() {
		$form = $("#form");
		//$form.attr("enctype", "multipart/form-data");
		newOrEidt();		
		$('#corpName').combobox({
			url : getContextPath() + '/enterprise/queryEnterpriseList',
			valueField : 'unitname',
			textField : 'unitname',
			onSelect : function(data) {
				$("#corpName").textbox('setValue', data.unitname);
			}
		});

	});
	function newOrEidt() {
		pkey = getUrlParam("pkey");
		mode = getUrlParam("mode");
		if (mode) {
			$(".show").each(function() {
				$(this).hide();
			});
		}
		if (pkey) {
			upUrl = getContextPath() + '/taxicar/edit';
			$.ajax({
				type : "post",
				dataType : "json",
				url : '../vehicle/queryOne?id=' + pkey,
				async : true,
				success : function(result) {
					if (result) {
						$form.form("load", result);
						//document.getElementById("uploadPreviewOwnerNamePic").src = "../vehicle/getOwnernamepic?id=" + pkey;
						$("#uploadPreviewOwnerNamePic").attr("src","../taxicar/getOwnernamepic?id=" + pkey);
						$("#uploadPreviewVehiclePic").attr("src","../taxicar/getVehiclepic?id=" + pkey);
					} else {
						showError("系统异常");
					}
				}
			})
		}
	}
	function back() {
		self.location.href = getContextPath() + "/taxicar/taxicarListPage";
	}
	function save() {
		//var file = $('#ownernamepic1').files[0];
		//var fileobj=file.files[0];
		//var file = document.getElementById('ownernamepic1').files[0];
		//alert(file);
		//校验
		var validate = $form.form('validate');
		if (validate == false) {
			return validate;
		}		
		var form=document.getElementById("form");
		var formData=new FormData(form);			
		
		$.ajax({
			type : "post",
			dataType : "json",
			url : upUrl,
			data : formData,
			async : false,
            cache: false,
            contentType: false,
            processData: false,
			success : function(result) {
				if (result.success) {
					parent.$.messager.progress('close');
					back();
				} else {
					parent.$.messager.progress('close');
					showError(result.msg);
				}
			}
		})
	}
	
</script>
</head>

<body class="easyui-layout" data-options="border:false"
	style="height: 100%">
	<div data-options="region:'north',border:false" style="height: 40px">
		<table>
			<tr>
				<td class="show"><a href="javascript:void(0);"
					class="easyui-linkbutton" style="margin: 5 0 0 5"
					data-options="iconCls:'icon-add',plain:true" onclick="save();">保存</a>
				</td>
				<td class="show">
					<div class="datagrid-btn-separator"></div>
				</td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton"
					style="margin: 5 0 0 5"
					data-options="iconCls:'icon-back',plain:true" onclick="back();">返回</a>
				</td>
			</tr>
		</table>
	</div>
	<div data-options="region:'center',border:true"
		style="height: 100%; padding-left: 15px">
		<form id="form" method="post"  enctype="multipart/form-data">
			<input name="id" type="hidden" />
			<table style="width: 90%">
			<tr>
				<td align="right" width="110px">档案号:</td>
				<td><input class="easyui-textbox" name="fileNum" type="text" style="width: 200px;" /></td>
				<td align="right" width="110px">车主姓名:</td>
				<td><input class="easyui-textbox" name="ownerName" type="text" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td align="right" width="110px">颜色:</td>
				<td><input class="easyui-textbox" name="color" type="text" style="width: 200px;" /></td>
				<td align="right" width="110px">车型:</td>
				<td><input class="easyui-textbox" name="sign" type="text" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td align="right" width="110px">营运证号:</td>
				<td><input class="easyui-textbox" name="opretaCertNum" type="text" style="width: 200px;" /></td>
				<td align="right" width="110px">原车主:</td>
				<td><input class="easyui-textbox" name="origOwnerName" type="text" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td align="right" width="110px">公司名称:</td>
				<td><input id="corpName" name="corpName" type="text" style="width: 200px;" /></td>
				<td align="right" width="110px">联系电话:</td>
				<td><input class="easyui-textbox" name="phoneNum" type="text" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td align="right" width="110px">变更日期:</td>
				<td><input class="Wdate" name="transferDate"  style="width: 200px;" 
				onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"/></td>
				<td align="right" width="110px">变更记录:</td>
				<td><input class="easyui-textbox" name="ownerChange" type="text" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td align="right" width="110px">车牌号:</td>
				<td><input class="easyui-textbox" name="plateNum" type="text" style="width: 200px;" /></td>
				<td align="right" width="110px">原车牌号:</td>
				<td><input class="easyui-textbox" name="origPlateNum" type="text" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td align="right" width="110px">查封记录:</td>
				<td><input class="easyui-textbox" name="sealRecord" type="text" style="width: 200px;" /></td>
				<td align="right" width="110px">行驶证初次登记:</td>
				<td><input class="easyui-textbox" name="drvLicenseDate" type="text" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td align="right" width="110px">身份证号:</td>
				<td><input class="easyui-textbox" name="iDNumber" type="text" style="width: 200px;" /></td>
				<td align="right" width="110px">发证日期:</td>
				<td><input  class="Wdate" name="checkDate" style="width: 200px;" 
				onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"/></td>
				
			</tr>
			<tr>
				<td align="right" width="110px">家庭住址:</td>
				<td  colspan="3"><input class="easyui-textbox" name="address" type="text" style="width: 722px;" /></td>
				
			</tr>
			<tr>
						
				<td align="right" width="110px">吨位:</td>
				<td><input class="easyui-textbox" name="tonsSeat" type="text" style="width: 200px;" /></td>
				<td align="right" width="110px">长:</td>
				<td><input class="easyui-textbox" name="carLen" type="text" style="width: 200px;" /></td>
							
			</tr>
			<tr>
						
				<td align="right" width="110px">宽:</td>
				<td><input class="easyui-textbox" name="carWidth" type="text" style="width: 200px;" /></td>
				<td align="right" width="110px">高:</td>
				<td><input class="easyui-textbox" name="carHigh" type="text" style="width: 200px;" /></td>
							
			</tr>
			<tr>
				<td align="right" width="110px" >车架号:</td>
				<td><input class="easyui-textbox" name="frameNumber" type="text" style="width: 200px;" /></td>
				<td align="right" width="110px">发动机号:</td>
				<td><input class="easyui-textbox" name="engineNumber" type="text" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td align="right" width="110px" height="100px">车辆审验记录:</td>
				<td  colspan="3"><input class="easyui-textbox" name="vehicleInspRec" type="text" style="width: 722px;height:100px;"  multiline="true"/></td>
				
			</tr>
			<tr>
				<td   colspan="2"  height="170px">
				<div style="width: 125px; height: 155px; margin-left: 110px;margin-top: 20px;" style="text-align: center;">
					<img id="uploadPreviewOwnerNamePic" style="width: 125px; height: 155px;" />
				<div style="text-align: center;"  class="show">
	         	<input id="ownernamepic1" name="ownernamepic1"  type="file"  onchange="loadImageFileOwnerNamePic();"/>上传车主照片
				</div>
	         		</div>
				</td>
				<td   colspan="2"  height="170px">
					<div style="width: 125px; height: 155px; margin-left: 110px;margin-top: 20px;" style="text-align: center;">
					<img id="uploadPreviewVehiclePic" style="width: 125px; height: 155px;" />
				<div style="text-align: center;"  class="show">
	         	<input id="vehiclepic1" name="vehiclepic1"  type="file"  onchange="loadImageFileVehiclepic();"/>上传车身照片
				</div>
	         		</div>
			    </td>
			</tr>
			
		</table>
			
		</form>
	</div>
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
		</script>
</body>
</html>