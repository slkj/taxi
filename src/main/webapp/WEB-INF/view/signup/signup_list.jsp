<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>人员信息</title>
<%@ include file="/common/taglibs.jsp"%>
<script>
	var $grid;
	var curUserComCode;
	$(function() {
		$grid = $("#list_data");
		initGrid();
	});
	function initGrid() {
		//datagrid初始化 
		$grid
				.datagrid({
					url : 'slistPage',
					striped : true,
					nowrap : false,
					fit : true,
					rownumbers : true,
					loadMsg : '正在加载中，请稍等... ',
					emptyMsg : '<span>无记录</span>',
					pagination : true,
					singleSelect : true,
					fitColumns : true,
					idField : 'pkey',
					pageSize : 10,
					pageList : [ 10, 20, 30, 40, 50, 100 ],
					columns : [ [
							{
								field : 'name',
								title : '姓名'
							},
							{
								field : 'sex',
								title : '性别',
								align : 'center',
								formatter : function(value, record, index) {
									if (value == 0) {
										return '<span style=color:red; >男</span>';
									} else if (value == 1) {
										return '<span style=color:green; >女</span>';
									}
								}
							},
							{
								field : 'idcard',
								title : '身份证号'
							},
							{
								field : 'phone',
								title : '联系电话'
							},
							{
								field : 'addtime',
								title : '报名日期'
							},
							{
								field : 'status',
								title : '状态',
								align : 'center',
								formatter : function(value, row, index) {
									if (value == 0) {
										return '<div style="background-color:#7b6f6f;text-align:center;color:#FFFFFF;">报名成功</div>';
									} else if (value == 1) {
										return '<div style="background-color:#3a87ad;text-align:center;color:#FFFFFF;">考试通过</div>';
									} else if (value == 2) {
										return '<div style="background-color:#1a1a1a;text-align:center;color:#FFFFFF;">考试未通过</div>';
									} else if (value == 3) {
										return '<div style="background-color:#356635;text-align:center;color:#FFFFFF;">出证完成</div>';
									}
								}
							},
							{
								field : 'opt',
								title : '操作',
								align : 'center',
								formatter : function(value, rec) {
									var str = "";
									str += '<span class="fa fa-eye "><a href="javascript:show(\''
											+ rec.id
											+ '\');" title="查看">查看</a></span>&nbsp&nbsp';
									str += '<span class="fa fa-pencil-square-o "><a href="javascript:edit(\''
											+ rec.id
											+ '\');" title="修改">修改</a></span>&nbsp&nbsp';
									str += '<span class="fa fa-times "><a href="javascript:del(\''
											+ rec.id
											+ '\');" title="删除">删除</a></span>';
									return str;
								}
							} ] ],
					onLoadSuccess : function(data) {
						if (data && data.rows && data.rows.length > 0) {
							$grid.datagrid("clearSelections");
						} else {
							$grid.datagrid("clearSelections");
						}
					}
				});
	}
	//添加
	function add() {
		layer.open({
			type : 2,
			skin : 'layui-layer-rim', //加上边框
			hade : [ 0.5, '#000', false ],
			area : [ '860px', '530px' ],
			title : [ '添加或修改用信息', false ],
			content : 'goAdd'
		});
	}
	//修改
	function edit(id) {
		layer.open({
			type : 2,
			skin : 'layui-layer-rim', //加上边框
			hade : [ 0.5, '#000', false ],
			area : [ '860px', '540px' ],
			title : [ '添加或修改用信息', false ],
			content : 'goEdit?id=' + id
		});
	}
	//详情
	function show(id) {
		layer.open({
			type : 2,
			skin : 'layui-layer-rim', //加上边框
			area : [ '860px', '500px' ], //宽高
			content : 'goShow?id=' + id
		});
	}
	//删除
	function del(id) {
		$.messager.confirm('提示', '确定要删除该记录?', function(r) {
			if (r) {
				$.ajax({
					url : "delete?id=" + id,
					success : function(data) {
						if (data) {
							$grid.datagrid('reload');
						} else {
							showError("操作失败");
						}
					}
				});
			}
		});
	}
	//查询
	function query() {
		$grid.datagrid({
			queryParams : {
				name : $('#name').val(),
				status : $('#status').val(),
				company : $('#company').val()
			}
		});
	}
</script>
</head>
<body class="easyui-layout" data-options="border:false, fit:true">
	<div data-options="region:'north',split:false" style="height: 90px">
		<div class="comp-search-box">
			<div class="screen-top">
				<div class="colRow">
					<input type="text" class="easyui-textbox" id="name" data-options="label:'姓名'" />
				</div>
				<div class="colRow">
					<!-- 					<input type="text" class="easyui-textbox" id="status" data-options="label:'状态'" />  -->
					<select class="easyui-combobox" name="status" id="status" data-options="label:'状态'"
						style="vertical-align: top; width: 120px;">
						<option value=""></option>
						<option value="">全部</option>
						<option value="0">报名成功</option>
						<option value="1">考试通过</option>
						<option value="2">考试未通过</option>
						<option value="3">出证完成</option>
					</select>
				</div>
				<div class="colRow">
					<input type="text" class="easyui-textbox" id="company" data-options="label:'公司名称'" />
				</div>
				<div class="colRow">
					<button class="easyui-linkbutton btnDefault" onclick="query()">
						<i class="fa fa-search"></i> 查询
					</button>
				</div>
			</div>
		</div>
		<div class="btnbar-tools">
			<a href="javascript:;" class="add" onclick="add()"> <i class="fa fa-plus "></i> 添加
			</a>
		</div>
	</div>
	<div data-options="region:'center',border:true">

		<table id=list_data data-options="fit:true,border:false"></table>
	</div>
	<!-- 新增和编辑数据 -->
	<div class="dig-wrapper" id="newData-wrapper">
		<div class="form1-column">
			<form id="vui_sample" class="easyui-form" method="post">
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="name" style="width: 100%" data-options="label:'姓名:',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="wznumber" style="width: 100%" data-options="label:'执法证号:',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="sqkf" style="width: 100%" data-options="label:'职务:',required:true">
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
</body>
</html>
