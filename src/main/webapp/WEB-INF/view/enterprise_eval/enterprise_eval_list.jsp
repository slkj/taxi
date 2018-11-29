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
						<input type="text" id="parent_id" data-options="label:'单位名称'" />
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
				<table id="enterpriseEvalList_dg"></table>
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
						<input class="easyui-textbox" id="parent_id1" name="parent_id" style="width: 100%" data-options="label:'企业名称:',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input  class="easyui-textbox" name="date"  style="width: 100%" data-options="label:'日期:'">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="project" style="width: 100%" data-options="label:'项目:'">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="reduction" style="width: 100%" data-options="label:'减分:'">
					</div>
				</div>			
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="plus" style="width: 100%" data-options="label:'加分:'">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="note" style="width: 100%" data-options="label:'备注:'">
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
			$grid = $("#enterpriseEvalList_dg");
			initGrid();
			//查询部分公司列表
			$('#parent_id').combobox({
				url : '../enterprise/queryEnterpriseList',
				valueField : 'unitname',
				textField : 'unitname',
				onSelect : function(data) {
					$("#parent_id").textbox('setValue', data.unitname);
				}
			});
			//新增数据
			$('#newData').on('click', function(){
				layer.open({
					type: 1,
					title:"企业信息",
					skin: 'layui-layer-rim', //加上边框
					area: ['450px', '450px'], //宽高
					content:$('#newData-wrapper'),
					zIndex:1000,
					end:function() {
						$('#vui_sample').form('clear');
					}
				});
			});
			//添加部分公司列表
			$('#parent_id1').combobox({
				url : '../enterprise/queryEnterpriseList',
				valueField : 'unitname',
				textField : 'unitname',
				onSelect : function(data) {
					$("#parent_id1").textbox('setValue', data.unitname);
				}
			});
			//查询
			$('#queryData').on('click', function() {
				$grid.datagrid({
					queryParams : {
						parent_id : $('#parent_id').combobox('getValue')
					}
				});
			});
		});
		function initGrid() {
			$grid.datagrid({
				url : '../enterpriseEval/list',//url调用Action方法  
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
			}
		function getColumns() {
			return [ [
					{title : '企业名称',field : 'parent_id'},
					{title : '日期',field : 'date'},
					{title : '减分',field : 'reduction'},
 					{title : '加分',field : 'plus'},
					{title : '备注',field : 'note'},
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
				url : "../enterpriseEval/save",
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
				url : "../enterpriseEval/delete",
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
					area : [ '450px', '450px' ], //宽高
					content : $('#newData-wrapper'),
					zIndex : 1000,
					end:function() {
						$('#vui_sample').form('clear');
					}
				});
				//$("#vui_sample").form("load", row);
				$.ajax({
					type : "post",
					dataType : "json",
					url : '../enterpriseEval/queryOne?id='+id,
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
