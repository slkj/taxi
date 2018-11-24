<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>承德市出租汽车管理系统</title>
<%@ include file="/common/taglibs.jsp"%>
<script src="${pageContext.request.contextPath}/assets/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/My97DatePicker/skin/WdatePicker.css">
</head>
<body scroll="no" class="body-pd10">
	<div class="dataView-container">
		<div class="table-container">
			<div class="tabs-wrapper">
				<div class="comp-search-box">
					<div class="screen-top">
						<div class="colRow">
							<input type="text" class="easyui-textbox" id="operatingnum" data-options="label:'营运证号'" />
						</div>
						<div class="colRow">
							<button class="easyui-linkbutton btnDefault" id="queryData">
								<i class="fa fa-search"></i>
								查询
							</button>
						</div>
					</div>
				</div>
				<div class="btnbar-tools">
					<a href="javascript:;" class="add" id="newData">
						<i class="fa fa-plus-square success"></i>
						添加
					</a>
				</div>
				<table id="list_data"></table>
			</div>
		</div>
	</div>
	<!-- 新增和编辑数据 -->
	<div class="dig-wrapper" id="newData-wrapper">
	<div id="topsearch" data-options="region:'north',border:false" style="height: 40px">
			
	<div class="comp-search-box">
			<div class="screen-top">
				<div class="colRow">
				<span style="margin-left: 20px;">请输入车辆营运证号：</span>
					<input type="text" class="easyui-textbox" id="opretaCertNum"/>
				</div>
				<div class="colRow">
					<button class="easyui-linkbutton btnDefault" id="queryData1">
						<i class="fa fa-search"></i> 查询
					</button>
				</div>
			</div>
		</div>
	
	</div>
	<div id="showPart" data-options="region:'center',border:true">
		<div title="表单示例" >
			<form id="vui_sample" class="easyui-form" >
				
				<table style="table-layout: fixed;" id="table_report" border="1"  class="table table-striped table-bordered table-hover">
		<tr>
			  <td colspan="3"><span
				style="margin-left: 20px;">档案号：</span> <span
				style="margin-left: 2px;"><input class="easyui-textbox" name="fileNum" type="text" style="width: 130px;" /></span></td>
			<td colspan="3"><span
				style="margin-left: 20px;">车主姓名：</span> <span
				style="margin-left: 2px;"><input class="easyui-textbox" name="ownerName" type="text" style="width: 120px;" /></span></td>
			<td colspan="2"><span
				style="margin-left: 20px;">颜色：</span> <span
				style="margin-left: 2px;"><input class="easyui-textbox" name="color" type="text" style="width: 60px;" /></span></td>
			<td colspan="2" style="width: 150px;" rowspan="5">
				<div style="width: 125px; height: 155px; margin: 2px;">
					<img id="uploadPreviewOwnerNamePic" style="width: 125px; height: 155px;" />
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
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="opretaCertNum" type="text" style="width: 115px;" /></span>
            </td>
            <td colspan="3">
              <span style="margin-left:20px;">原车主：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="origOwnerName" type="text" style="width: 135px;" /></span>
            </td>
            <td colspan="2">
              <span style="margin-left:20px;">车型：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="sign" type="text" style="width: 60px;" /></span>
            </td>
          </tr>
          <tr>
            <td colspan="4">
              <span style="margin-left:20px;">公司名称：</span>
                    <span style="margin-left:2px;"><input id="corpName" name="corpName" type="text" style="width: 210px;" /></span>
            </td>
            <td colspan="4">
              <span style="margin-left:20px;">联系电话：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="phoneNum" type="text" style="width: 120px;" /></span>
            </td>
          </tr>
          <tr>
            <td colspan="8">
              <span style="margin-left:20px;">变更日期：</span>
                    <span style="margin-left:2px;"><input class="Wdate" name="transferDate"  style="width: 120px;" 
				onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"/></span>
              <span style="margin-left:20px;">变更记录：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="ownerChange" type="text" style="width: 120px;" /></span>
              <span style="margin-left:20px;">查封记录：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="sealRecord" type="text" style="width: 125px;" /></span>
            </td>
          </tr>
          <tr>
            <td colspan="8">
              <span style="margin-left:20px;">车牌号：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="plateNum" type="text" style="width: 100px;" /></span>
              <span style="margin-left:20px;">原车号：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="origPlateNum" type="text" style="width: 100px;" /></span>
              <span style="margin-left:20px;">行驶证初次登记：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="drvLicenseDate" type="text" style="width: 158px;" /></span>
            </td>
          </tr>
          <tr>
			<td colspan="7"><span
				style="margin-left: 20px;">身份证号：</span> <span
				style="margin-left: 2px;"><input class="easyui-textbox" name="iDNumber" type="text" style="width: 450px;" /></span></td>
			<td colspan="3" style="width: 202px;" rowspan="3">
				<div style="width: 185px; height: 110px; margin: 2px;margin-left: 15px;">
						<img id="uploadPreviewVehiclePic" style="width: 185px; height: 110px;" />
					
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
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="address" type="text" style="width: 450px;" /></span>
            </td>
          </tr>
          <tr>
          	<td colspan="7">
              <span style="margin-left:20px;">吨（座）位：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="tonsSeat" type="text" style="width: 60px;" /></span>
              <span style="margin-left:20px;">长：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="carLen" style="width:60px;" type="text"></span>
              <span style="margin-left:20px;">宽：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="carWidth" style="width:60px;" type="text"></span>
              <span style="margin-left:20px;">高：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="carHigh" style="width:60px;" type="text"></span>
            </td>
          </tr>
          <tr>
          	<td colspan="5">
              <span style="margin-left:20px;">车架号：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="frameNumber" style="width:270px;" type="text"></span>
            </td>
            <td colspan="5">
              <span style="margin-left:20px;">发动机号：</span>
                    <span style="margin-left:2px;"><input class="easyui-textbox" name="engineNumber" style="width:270px;" type="text"></span>
            </td>
          </tr>
          <tr>
          	<td colspan="10">
              <span style="margin-left:20px;">发证日期：</span>
                    <span style="margin-left:2px;"><input  class="Wdate" name="checkDate" style="width: 270px;" 
				onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"/></span>
            </td>
          </tr>
          <tr>
          	<td colspan="10">
              <span style="margin-left:20px;">车辆审验记录：</span>
                    <span style="margin-left:2px;">
                    	<input class="easyui-textbox" name="vehicleInspRec" type="text" style="width: 665px;height:60px;"  multiline="true"/>
                    </span>
            </td>
          </tr>
          	</table>
          		</form>
          		<form id="vui_sample1" class="easyui-form" >
			<table  id="table_report1" style="table-layout: fixed;"  border="1" class="table table-striped table-bordered table-hover">
						<input type="hidden" name="id">
						<input type="hidden" name="operatingnum" id="operatingnum1"/>
						<tr>
				        	<td>
				            	<span style="margin-left:20px;">年审日期：</span>
		            		</td>
				        	<td>
				            	<span style="margin-left:10px;">
<input  class="Wdate" name="annualdate" style="width: 150px;" 
				onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"/></span>
		            		</td>
				        	<td>
				            	<span style="margin-left:20px;">下一年审日期：</span>
		            		</td>
				        	<td>
				            	<span style="margin-left:10px;"><input  class="Wdate" name="nextannualdate" style="width: 150px;" 
				onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"/></span>
		            		</td>
		        		</tr>
		        		<tr>
				        	<td>
				            	<span style="margin-left:20px;">车辆级别：</span>
		            		</td>
				        	<td colspan="3">
				            	<span style="margin-left:10px;">
				            		<select style="width:150px;" class="easyui-combobox"  name="vehicle" title="车辆级别">
										<option value="1">一级车</option>
										<option value="2">二级车</option>
									</select>
								</span>
		            		</td>
		        		</tr>
						<tr>
							<td style="text-align: center;"  colspan="4">
								<input type="submit" name="" value="保存" class="easyui-linkbutton btnPrimary" onclick="submitForm()" style="width: 80px" />
								<input type="submit" name="" value="重置" class="easyui-linkbutton btnDefault" onclick="clearForm()" style="width: 80px" />
							</td>
						</tr>
					</table>
         </form>
				
		
		</div>
		</div>
	</div>
	<script type="text/javascript">
		var $grid;
		$(function() {
			$grid = $("#list_data");
			initGrid();
			$('#corpName').combobox({
				url : '../enterprise/queryEnterpriseList',
				valueField : 'unitname',
				textField : 'unitname',
				onSelect : function(data) {
					$("#corpName").textbox('setValue', data.unitname);
				}
			});
			//新增数据
			$('#newData').on('click', function() {
				layer.open({
					type : 1,
					title : "年审信息",
					skin : 'layui-layer-rim', //加上边框
					area : [ '1000px', '560px' ], //宽高
					content : $('#newData-wrapper'),
					zIndex : 1000
				});
				loadAddCheckForm();
			});
			$('#queryData').on('click', function() {
				$grid.datagrid({
					queryParams : {
						operatingnum : $('#operatingnum').val()
					}
				});
			});
		});
		function initGrid() {
			//datagrid初始化 
			$grid.datagrid({
				url : '../taxicarCheck/checkList',
				striped : true,
				nowrap : false,
				rownumbers : true,
				loadMsg : '正在加载中，请稍等... ',
				emptyMsg : '<span>无记录</span>',
				pagination : true,
				singleSelect : true,
				fitColumns : true,
				idField : 'pkey',
				pageSize : 10,
				pageList : [ 10, 20, 30, 40, 50, 100 ],
				columns : getColumns()
			});
		}
		function getColumns() {
			return [ [ 
			           		{								
								field : 'operatingnum',
								title : '营运证号'
							}, {								
								field : 'annualdate',
								title : '年审日期'
							}, {								
								field : 'nextannualdate',
								title : '终止日期'
							},  {
								field : 'status',
								title : '状态',
								align : 'center',
								formatter : function(value, row) {
										if(value==0){
											return '<span style="color:DarkGreen">年审完成</span>';
										}
										else if(value==1){
											return '<span style="color:Chocolate">待上级审核</span>';
										}
										else if(value==2){
											return '<span style="color:red">上级审核完成</span>';
										}
										else if(value==3){
											return '<span style="color:DimGray">上级审核失败</span>';
										}
										
									}
								}, {
							field : 'opt',
							title : '操作',
							align : 'center',
							formatter : function(value, row) {
								var s = '<div class ="updateBtn">';
								s += '<a href="javascript:void(0);" title="删除"  onclick="delRow(\''+row.id+'\')" class="danger delMsg"><i class="fa fa-trash"></i></a>';
								s += ' <a href="javascript:void(0);" title="编辑" onclick="editRow(\''+row.id+'\',\''+row.operatingnum+'\')" class="info"><i class="fa fa-pencil-square-o"></i></a></div>';
								return s;
							}
						} ] ];
		}
		function submitForm(){//保存提交 
			//校验
			var validate = $("#vui_sample1").form('validate');
			if (!validate) {
				return validate;
			}
			var data =$("#vui_sample1").serializeArray();
			$.ajax({
				type : "POST",
				url : "../taxicarCheck/saveCheck",
				data : data,
				async : false,
	            cache: false,
				success : function(data) {
					if (data) {
						$grid.datagrid('reload');// 刷新datagrid
						layer.close(layer.index); 
						clearForm();
					} else {
						msgShow('系统提示', '出现异常');
					}
				}
			});
		}
		//修改
		function editRow(id,operatingnum) {
			if (id) {
				layer.open({
					type : 1,
					title : "年审信息",
					skin : 'layui-layer-rim', //加上边框
					area : [ '1000px', '560px' ], //宽高
					content : $('#newData-wrapper'),
					zIndex : 1000
				});
				loadEditCheckForm(id,operatingnum);
			}
		}
		function clearForm(){//重置表单
			$('#vui_sample1').form('clear');
			$("#opretaCertNum").textbox('setValue','')
		}
		//删除
		function delRow(id) {
			if (confirm("确定要删除吗？")) {
				$.ajax({
					cache : false,
					type : "POST",
					url : "../taxicarCheck/deleteCheck",
					data : {
						id : id
					},
					async : false,
					success : function(data) {
						if (data) {
							$grid.datagrid('reload');// 刷新datagrid
						} else {
							msgShow('系统提示', '出现异常');
						}
					}
				});
				}
		}
		function loadAddCheckForm(){
			$("#topsearch").show();		
			$('#showPart').hide();
			$('#queryData1').on('click', function() {
				var opretaCertNum=$('#opretaCertNum').val();
				if(opretaCertNum){
				$.ajax({
					type : "post",
					dataType : "json",
					url : '../taxicar/queryOne?opretaCertNum=' + opretaCertNum,
					async : true,
					success : function(result) {
						if (result) {
							$('#showPart').show();
							$("#vui_sample").form("load", result);	
							 $("#operatingnum1").attr("value", opretaCertNum);
							//document.getElementById("uploadPreviewOwnerNamePic").src = "../vehicle/getOwnernamepic?id=" + pkey;
							$("#uploadPreviewOwnerNamePic").attr("src","../taxicar/getOwnernamepic?opretaCertNum=" + opretaCertNum);
							$("#uploadPreviewVehiclePic").attr("src","../taxicar/getVehiclepic?opretaCertNum=" + opretaCertNum);
						} else {
							msgShow('系统提示', '未找到相关信息');
						}
					}
				})
				}else{
					msgShow('系统提示', '请输入正确的营运证号');
				}
			});
		}
		function loadEditCheckForm(id,operatingnum){
			$("#topsearch").hide();		
			$('#showPart').show();
			$.ajax({
				type : "post",
				dataType : "json",
				url : '../taxicar/queryOne?opretaCertNum='+operatingnum,
				async : true,
				success : function(result) {
					if (result) {
						$("#vui_sample").form("load", result);	
						$("#uploadPreviewOwnerNamePic").attr("src","../taxicar/getOwnernamepic?opretaCertNum=" + operatingnum);
						$("#uploadPreviewVehiclePic").attr("src","../taxicar/getVehiclepic?opretaCertNum=" + operatingnum);
					} else {
						showError("系统异常");
					}
				}
			})
			$.ajax({
				type : "post",
				dataType : "json",
				url : '../taxicarCheck/queryOneCheck?id='+id,
				async : true,
				success : function(result) {
					if (result) {
						$("#vui_sample1").form("load", result);							
					} else {
						showError("系统异常");
					}
				}
			})
		}
	</script>
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
