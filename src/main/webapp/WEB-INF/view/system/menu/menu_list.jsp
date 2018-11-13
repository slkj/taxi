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
					<a href="javascript:;" class="add" id="newData"><i class="fa fa-plus-square success"></i>添加</a>
				</div>
				<table id="menuList_dg"></table>
			</div>
		</div>
	</div>
	<!-- 新增和编辑数据 -->
	<div class="dig-wrapper" id="newData-wrapper" style="text-align: center;">
		<div class="form-column1">
			<div class="form-column-left">
				<input class="easyui-textbox" id="rolenameText" style="width: 350px" data-options="required:true">
			</div>
		</div>
		<div class="form-btnBar ">
			<input type="submit" name="" value="保存" class="easyui-linkbutton btnPrimary" onclick="submitForm()"
				style="width: 80px" />
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
		});
		function initGrid() {
			$grid
					.treegrid({
						url : '../menu/listMenuTree',
						loadMsg : '数据加载中....',
						fit : true,
						nowrap : true, //false:折行
						striped : true, //隔行变色
						checkOnSelect : true,
						idField : 'id',
						treeField : 'name',
						lines : true,
						animate : true,
						height : 450,
						columns : [ [
								{
									field : 'name',
									title : '资源名称',
									width : 180
								},
								{
									field : 'url',
									title : 'url'
								},
								{
									field : 'icon',
									title : '图标'
								},
								{
									field : 'description',
									title : '说明'
								},
								{
									field : 'opt',
									title : '操作',
									width : 100,
									align : 'center',
									formatter : function(value, row) {
										var s = "";
										s += "<a href=\"javascript:void(0)\" onclick=\"editRow('"
												+ row.id + "');\">编辑</a>";
										s += "|";
										s += "<a href=\"javascript:void(0)\" onclick=\"javaScript:deleteRow();\"> 删除 </a>";
										if (row.parent_id == "0") {
											return "";
										}
										return s;
									}
								} ] ]
					});
		}
	</script>
</body>
</html>