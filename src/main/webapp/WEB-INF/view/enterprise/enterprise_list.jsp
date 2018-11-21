<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>承德市出租汽车管理系统</title>
<%@ include file="/common/taglibs.jsp"%>
</head>
<body scroll="no" class="body-pd10">
	<div class="dataView-container">
		<div class="table-container">
			<div class="tabs-wrapper">
				<div class="comp-search-box">
					<div class="screen-top">
						<div class="colRow">
						<input type="text" class="easyui-textbox" id="unitname" data-options="label:'单位名称'" />
						</div>
						<div class="colRow">
							<input type="text" class="easyui-textbox" id="businessno" data-options="label:'经营许可证号'" />
						</div>
						<div class="colRow">
							<input type="text" class="easyui-textbox" id="legalrepresentative" data-options="label:'法人代表'" />
						</div>
						<div class="colRow">
							<button class="easyui-linkbutton btnDefault"  id="queryData">
								<i class="fa fa-search"></i>查询
							</button>
						</div>
					</div>
				</div>
				<div class="btnbar-tools">
					<a href="javascript:;" class="add" id="newData"><i class="fa fa-plus-square success"></i>添加</a>
				</div>
				<table id="enterpriseList_dg"></table>
			</div>
		</div>
	</div>
	<!-- 新增和编辑数据 -->
	<div class="dig-wrapper" id="newData-wrapper">
		<div class="form1-column" title="表单示例">
			<form id="vui_sample" class="easyui-form" >
				<input type="hidden" name="id">
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="unitname" style="width: 100%" data-options="label:'单位名称:',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="phone" style="width: 100%" data-options="label:'联系电话:',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="unitaddr" style="width: 100%" data-options="label:'单位地址:',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="businessscope" style="width: 100%" data-options="label:'经营范围:',required:true">
					</div>
				</div>			
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="businessno" style="width: 100%" data-options="label:'经营许可证号:',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="enterprisecode" style="width: 100%" data-options="label:'企业代码:',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="regcapital" style="width: 100%" data-options="label:'注册资本:',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="economytype" style="width: 100%" data-options="label:'经济类型:',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="legalrepresentative" style="width: 100%" data-options="label:'法人代表:',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="vehiclesnum" style="width: 100%" data-options="label:'车辆总数:',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="employeescount" style="width: 100%" data-options="label:'从业人员总数:',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="manageersonnel" style="width: 100%" data-options="label:'安全管理人员总数:',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="carnum" style="width: 100%" data-options="label:'企业自有车数:',required:true">
					</div>
				</div>
				<div class="form-btnBar pl75">
					<input type="submit" name="" value="保存" class="easyui-linkbutton btnPrimary" onclick="submitForm()"
						style="width: 80px" /> <input type="submit" name="" value="重置" class="easyui-linkbutton btnDefault"
						onclick="clearForm()" style="width: 80px" />
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
	var $grid;
		$(function() {
			$grid = $("#enterpriseList_dg");
			$grid.datagrid({
				url : '../enterprise/list',//url调用Action方法  
				loadMsg : '数据装载中......',
				singleSelect : true,//为true时只能选择单行  
				fitColumns : true,//允许表格自动缩放，以适应父容器  
				remoteSort : false,
				pagination : true,//分页  
				rownumbers : true,//行数  
				pageSize : 10,//默认选择的分页是每页5行数据  
				pageList : [ 10, 15, 20 ],//可以选择的分页集合  
				nowrap : true,//设置为true，当数据长度超出列宽时将会自动截取  
				striped : true,//设置为true将交替显示行背景。 
				columns : getColumns()
			});
			//新增数据
			$('#newData').on('click', function(){
				layer.open({
					type: 1,
					title:"企业信息",
					skin: 'layui-layer-rim', //加上边框
					area: ['490px', '500px'], //宽高
					content:$('#newData-wrapper'),
					zIndex:1000
				});
			});
			//查询
			$('#queryData').on('click', function() {
				$grid.datagrid({
					queryParams : {
						unitname : $('#unitname').val(),
						businessno : $('#businessno').val(),
						legalrepresentative : $('#legalrepresentative').val()
					}
				});
			});
		});
		function getColumns() {
			return [ [
					{title : '企业名称',field : 'unitname'},
					{title : '联系电话',field : 'phone'},
					{title : '经营许可证号',field : 'businessno'},
 					{title : '企业代码',field : 'enterprisecode'},
					{title : '法人代表',field : 'legalrepresentative'},
					{field : 'opt',title : '操作',align : 'center',	formatter : function(value, row) {
						var s = '<div class ="updateBtn">';
						s += '<a href="javascript:void(0);" title="删除"  onclick="delRow(\''+row.id+'\')" class="danger delMsg"><i class="fa fa-trash"></i></a>';
						s += ' <a href="javascript:void(0);" title="编辑" onclick="editRow(\''+row.id+'\')" class="info"><i class="fa fa-pencil-square-o"></i></a></div>';
						return s;
						}
					} ] ];
		}
		function submitForm(){//保存提交
			//校验
			var validate = $("#vui_sample").form('validate');
			if (!validate) {
				return validate;
			}
			var data =$("#vui_sample").serializeArray();
			$.ajax({
				cache : false,
				type : "POST",
				url : "../enterprise/save",
				data : data,
				async : false,
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
		function clearForm(){//重置表单
			$('#vui_sample').form('clear');
		}
		function delRow(id) {
			if (confirm("确定要删除吗？")) {
			$.ajax({
				cache : false,
				type : "POST",
				url : "../enterprise/delete",
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
		function editRow(id) {
			//var row = $('#enterpriseList_dg').datagrid('getSelected');
			 if (id) {
				layer.open({
					type : 1,
					title : "用户信息",
					skin : 'layui-layer-rim', //加上边框
					area : [ '490px', '500px' ], //宽高
					content : $('#newData-wrapper'),
					zIndex : 1000
				});
				//$("#vui_sample").form("load", row);
				$.ajax({
					type : "post",
					dataType : "json",
					url : '../enterprise/queryOne?id='+id,
					async : true,
					success : function(result) {
						if (result) {
							$("#vui_sample").form("load", result);	
						} else {
							showError("系统异常");
						}
					}
				})
			} 
		}
	</script>
</body>
</html>
