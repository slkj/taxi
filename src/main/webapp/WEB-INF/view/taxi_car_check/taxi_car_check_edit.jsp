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
	var $checkForm;
	var upUrl = getContextPath() + '/taxicarCheck/saveCheck';
	var pkey;
	var opr;
	$(function() {
		$form = $("#form");
		$checkForm=$("#checkForm");
		//$form.attr("enctype", "multipart/form-data");		
		$('#showPart').hide();
		newOrEidt();
	});
	function newOrEidt() {
		pkey = getUrlParam("pkey");
		opr = getUrlParam("opr");
		if (pkey) {
			upUrl = getContextPath() + '/taxicarCheck/editCheck';
			$.ajax({
				type : "post",
				dataType : "json",
				url : '../taxicarCheck/queryOneCheck?id=' + pkey,
				async : true,
				success : function(result) {
					if (result) {
						$checkForm.form("load", result);
						$("#topsearch").hide();						
						loadVehicle(opr);
					} else {
						showError("系统异常");
					}
				}
			})			
			$('#showPart').show();
		}
	}
	function loadVehicle(opretaCertNum) {
				$.ajax({
				type : "post",
				dataType : "json",
				url : '../taxicar/queryOneByOpr?opretaCertNum=' + opretaCertNum,
				async : true,
				success : function(result) {
					if (result) {
						$form.form("load", result);
						//document.getElementById("uploadPreviewOwnerNamePic").src = "../vehicle/getOwnernamepic?id=" + pkey;
						$("#uploadPreviewOwnerNamePic").attr("src","../taxicar/getOwnernamepic?operatingnum=" + opr);
						$("#uploadPreviewVehiclePic").attr("src","../taxicar/getVehiclepic?operatingnum=" + opr);
					} else {
						showError("系统异常");
					}
				}
			})
			
			
	}
	function back() {
		self.location.href = getContextPath() + "/taxicarCheck/taxicarCheckListPage";
	}
	function save() {
		var validate = $checkForm.form('validate');
		if (!validate) {
			return validate;
		}
		var data = serializeObject($checkForm);
		$.ajax({
			type : "post",
			dataType : "json",
			url : upUrl,
			data:data,
			async : true,
			success : function(result) {
				if (result) {
					parent.$.messager.progress('close');
					back();
				} else {
					showError("添加失败！");
				}
			}
		})
	}
function query() {
		var opretaCertNum=$('#opretaCertNum').val();
		if(operatingnum){
		$.ajax({
			type : "post",
			dataType : "json",
			url : '../taxicar/queryOneByOpr?opretaCertNum=' + opretaCertNum,
			async : true,
			success : function(result) {
				if (result) {
					$('#showPart').show();
					$form.form("load", result);
					 $("#operatingnum").attr("value", opretaCertNum);
					//document.getElementById("uploadPreviewOwnerNamePic").src = "../vehicle/getOwnernamepic?id=" + pkey;
					$("#uploadPreviewOwnerNamePic").attr("src","../taxicar/getOwnernamepic?operatingnum=" + opretaCertNum);
					$("#uploadPreviewVehiclePic").attr("src","../taxicar/getVehiclepic?operatingnum=" + opretaCertNum);
				} else {
					showError("未找到相关信息");
				}
			}
		})
		}else{
			showError("请输入正确的营运证号");
		}
	}
</script>
</head>

<body class="easyui-layout" data-options="border:false"
	style="height: 100%">
	<div id="topsearch" data-options="region:'north',border:false" style="height: 40px">
			
	<div class="comp-search-box">
			<div class="screen-top">
				<div class="colRow">
				<span style="margin-left: 20px;">请输入车辆营运证号：</span>
					<input type="text" class="easyui-textbox" id="opretaCertNum"/>
				</div>
				<div class="colRow">
					<button class="easyui-linkbutton btnDefault" onclick="query()">
						<i class="fa fa-search"></i> 查询
					</button>
				</div>
			</div>
		</div>
	
	</div>
	<div id="showPart" data-options="region:'center',border:true"
		style="height: 100%; padding-left: 15px">
		
		<form id="form" method="post">
			
			<table style="width: 90%">
			<tr>
				<td align="right" width="70px">档案号:</td>
				<td><input class="easyui-textbox" name="fileNum" type="text" style="width: 200px;" /></td>
				<td align="right" width="70px">车主姓名:</td>
				<td><input class="easyui-textbox" name="ownerName" type="text" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td align="right" width="70px">颜色:</td>
				<td><input class="easyui-textbox" name="color" type="text" style="width: 200px;" /></td>
				<td align="right" width="70px">车型:</td>
				<td><input class="easyui-textbox" name="sign" type="text" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td align="right" width="70px">营运证号:</td>
				<td><input class="easyui-textbox" name="opretaCertNum" type="text" style="width: 200px;" /></td>
				<td align="right" width="70px">原车主:</td>
				<td><input class="easyui-textbox" name="origOwnerName" type="text" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td align="right" width="70px">公司名称:</td>
				<td><input class="easyui-textbox" name="corpName" type="text" style="width: 200px;" /></td>
				<td align="right" width="70px">联系电话:</td>
				<td><input class="easyui-textbox" name="phoneNum" type="text" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td align="right" width="70px">变更日期:</td>
				<td><input class="Wdate" name="transferDate"  style="width: 200px;" 
				onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"/></td>
				<td align="right" width="70px">变更记录:</td>
				<td><input class="easyui-textbox" name="ownerChange" type="text" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td align="right" width="70px">车牌号:</td>
				<td><input class="easyui-textbox" name="plateNum" type="text" style="width: 200px;" /></td>
				<td align="right" width="70px">原车牌号:</td>
				<td><input class="easyui-textbox" name="origPlateNum" type="text" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td align="right" width="70px">查封记录:</td>
				<td><input class="easyui-textbox" name="sealRecord" type="text" style="width: 200px;" /></td>
				<td align="right" width="70px">行驶证初次登记:</td>
				<td><input class="easyui-textbox" name="drvLicenseDate" type="text" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td align="right" width="70px">身份证号:</td>
				<td><input class="easyui-textbox" name="iDNumber" type="text" style="width: 200px;" /></td>
				<td align="right" width="70px">发证日期:</td>
				<td><input  class="Wdate" name="checkDate" style="width: 200px;" 
				onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"/></td>
				
			</tr>
			<tr>
				<td align="right" width="70px">家庭住址:</td>
				<td  colspan="3"><input class="easyui-textbox" name="address" type="text" style="width: 722px;" /></td>
				
			</tr>
			<tr>
						
				<td align="right" width="70px">吨位:</td>
				<td><input class="easyui-textbox" name="tonsSeat" type="text" style="width: 200px;" /></td>
				<td align="right" width="70px">长:</td>
				<td><input class="easyui-textbox" name="carLen" type="text" style="width: 200px;" /></td>
							
			</tr>
			<tr>
						
				<td align="right" width="70px">宽:</td>
				<td><input class="easyui-textbox" name="carWidth" type="text" style="width: 200px;" /></td>
				<td align="right" width="70px">高:</td>
				<td><input class="easyui-textbox" name="carHigh" type="text" style="width: 200px;" /></td>
							
			</tr>
			<tr>
				<td align="right" width="70px" >车架号:</td>
				<td><input class="easyui-textbox" name="frameNumber" type="text" style="width: 200px;" /></td>
				<td align="right" width="70px">发动机号:</td>
				<td><input class="easyui-textbox" name="engineNumber" type="text" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td align="right" width="70px" height="100px">车辆审验记录:</td>
				<td  colspan="3"><input class="easyui-textbox" name="vehicleInspRec" type="text" style="width: 722px;height:100px;"  multiline="true"/></td>
				
			</tr>
			<tr>
				<td   colspan="2"  height="170px">
				<div style="width: 125px; height: 155px; margin-left: 70px;margin-top: 20px;" style="text-align: center;">
					<img id="uploadPreviewOwnerNamePic" style="width: 125px; height: 155px;" />
				
	         		</div>
				</td>
				<td   colspan="2"  height="170px">
					<div style="width: 125px; height: 155px; margin-left: 70px;margin-top: 20px;" style="text-align: center;">
					<img id="uploadPreviewVehiclePic" style="width: 125px; height: 155px;" />
				
	         		</div>
			    </td>
			</tr>			
		</table>			
		</form>
		<form id="checkForm" method="post">
		<table  style="width: 90%">
						<input name="id" type="hidden" />
						<input type="hidden" name="operatingnum" id="operatingnum"/>
						<tr>
				        	<td align="right" width="70px" >
				            	年审日期：
		            		</td>
				        	<td>
				            	<input  class="Wdate" name="annualdate" style="width: 200px;" 
				onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"/>
		            		</td>
				        	<td align="right" width="70px" >
				            	下一年审日期：
		            		</td>
				        	<td>
				            	<input  class="Wdate" name="nextannualdate" style="width: 200px;" 
				onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"/>
		            		</td>
		        		</tr>
		        		<tr>
				        	<td align="right" width="70px" >
				            	车辆级别：
		            		</td>
				        	<td colspan="3">
				            	
				            		<select style="width:200px;" class="easyui-combobox"  name="vehicle" title="车辆级别">
										<option value="1">一级车</option>
										<option value="2">二级车</option>
									</select>
								
		            		</td>
		        		</tr>
						<!-- <tr>
							<td class="center" colspan="10">
								<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
								<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
							</td>
						</tr> -->
					</table>
					</form>
					<table  align="center">
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
	
</body>
</html>