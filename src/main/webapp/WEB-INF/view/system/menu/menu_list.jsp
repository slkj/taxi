<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>菜单管理</title>
<link href="../assets/css/reset.css" rel="stylesheet" type="text/css" />
<link href="../assets/js/themes/default/easyui.css" rel="stylesheet" type="text/css" />
<link href="../assets/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="../assets/css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body scroll="no" class="body-pd10">
	<div class="dataView-container">
		<div class="table-container">
			<div class="tabs-wrapper">
				<div class="btnbar-tools">
					<a href="javascript:;" class="add" id="newData">
						<i class="fa fa-plus-square success"></i>
						添加
					</a>
				</div>
				<table id="menuList_dg"></table>
			</div>
		</div>
	</div>
	<!-- 新增和编辑数据 -->
	<div class="dig-wrapper" id="newData-wrapper">
		<div class="form1-column">
			<form id="vui_sample" class="easyui-form">
				<input type="hidden" name="id">
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="name" style="width: 100%" data-options="label:'菜单名称',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-combotree" id="parent_id" name="parent_id" style="width: 100%" data-options="label:'上级菜单:',url :'../menu/getCombotree',lines : true,required : true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="url" style="width: 100%" data-options="label:'资源路径:'">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="icon" style="width: 100%" data-options="label:'图标:',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="sort" style="width: 100%" data-options="label:'顺序:',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<select class="easyui-combobox" name="priority" data-options="label:'菜单类型:',required:true" labelPosition="top" style="width: 100%;">
							<option value="1">一级菜单</option>
							<option value="2">二级菜单</option>
							<option value="3">菜单按钮</option>
							<option value="4">行按钮</option>
						</select>
					</div>
				</div>
				<div class="form-btnBar pl75">
					<input type="submit" name="" value="保存" class="easyui-linkbutton btnPrimary" onclick="submitForm()" style="width: 80px" />
					<input type="submit" name="" value="重置" class="easyui-linkbutton btnDefault" onclick="clearForm()" style="width: 80px" />
				</div>
			</form>
		</div>
	</div>
	<script src="../assets/js/jquery2.1.1.js" type="text/javascript"></script>
	<script src="../assets/js/jquery.easyui.min.js" type="text/javascript"></script>
	<script src="../assets/js/easyui-lang-zh_CN.js" type="text/javascript"></script>
	<script src="../assets/js/layer.js" type="text/javascript"></script>
	<script type="text/javascript">
		var $grid;
		$(function() {
			$grid = $('#menuList_dg');
			initGrid();
			//新增数据
			$('#newData').on('click', function(){
				layer.open({
					type: 1,
					title:"菜单信息",
					skin: 'layui-layer-rim', //加上边框
					area: ['490px', '450px'], //宽高
					content:$('#newData-wrapper'),
					zIndex:1000
				});
			});
		});
		function initGrid() {
			$grid.treegrid({
				url : '../menu/listMenuTree',
				loadMsg : '数据加载中....',
				nowrap : true, //false:折行
				striped : true, //隔行变色
				checkOnSelect : true,
				idField : 'id',
				treeField : 'name',
				lines : true,
				animate : true,
				columns : [ [ 
					{field : 'name',title : '资源名称',width : 180}, 
					{field : 'url',title : '资源路径'}, 
					{field : 'icon',title : '图标'}, 
					{field : 'sort',title : '排序'}, 
					{field : 'opt',title : '操作',width : 100,align : 'center',
						formatter : function(value, row) {
							var s = '<div class ="updateBtn">';
							s += '<a href="javascript:void(0);" title="删除"  onclick="delRow('+row.id+')" class="danger delMsg"><i class="fa fa-trash"></i></a>';
							s += ' <a href="javascript:void(0);" title="编辑" onclick="editRow()" class="info"><i class="fa fa-pencil-square-o"></i></a></div>';
							if (row.parent_id == "0") {
								return "";
							}
							return s;
						}
					} ] ]
			});
		}
		
		function submitForm() {//保存提交
			//校验
			var validate = $("#vui_sample").form('validate');
			if (!validate) {
				return validate;
			}
			var data = $("#vui_sample").serializeArray();
			$.ajax({
				cache : false,
				type : "POST",
				url : "../menu/add",
				data : data,
				async : false,
				success : function(data) {
					if (data) {
						$('#menuList_dg').treegrid('reload');// 刷新datagrid
						layer.close(layer.index);
						clearForm();
					} else {
						msgShow('系统提示', '出现异常');
					}
				}
			});
		}
		function clearForm() {//重置表单
			$('#vui_sample').form('clear');
		}
		function delRow(id) {
			$.ajax({
				cache : false,
				type : "POST",
				url : "../menu/delete",
				data : {
					id : id
				},
				async : false,
				success : function(data) {
					if (data) {
						$('#menuList_dg').treegrid('reload');// 刷新datagrid
					} else {
						msgShow('系统提示', '出现异常');
					}
				}
			});
		}
		
		function editRow() {
			var row = $('#menuList_dg').datagrid('getSelected');
			if (row) {
				layer.open({
					type : 1,
					title : "用户信息",
					skin : 'layui-layer-rim', //加上边框
					area : [ '490px', '450px' ], //宽高
					content : $('#newData-wrapper'),
					zIndex : 1000
				});
				$("#vui_sample").form("load", row);
			}
		}
	</script>
</body>
</html>