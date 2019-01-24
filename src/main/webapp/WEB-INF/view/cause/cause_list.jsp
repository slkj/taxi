﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>考试报名</title>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
	var $grid;
	$(function() {
		$grid = $("#list_data");
		initGrid();
	});
	function initGrid() {
		//datagrid初始化 
		$grid.datagrid({
			url : '../cause/listData',
			striped : true,
			nowrap : false,
			rownumbers : true,
			loadMsg : '正在加载中，请稍等... ',
			emptyMsg : '<span>无记录</span>',
			pagination : true,
			singleSelect : true,
			idField : 'pkey',
			pageSize : 10,
			pageList : [ 10, 20, 30, 40, 50, 100 ],
			columns : [ [  {
				field : 'AY',
				title : '案由'
			}, {
				field : 'opt',
				title : '操作',
				align : 'center',
				formatter : function(value, rec) {
					var s = '<div class ="updateBtn">';
					s += '<a href="javascript:void(0);" title="删除" onclick="delRow()" class="danger delMsg"><i class="fa fa-eye"></i></a>';
					s += '<a href="javascript:void(0);" title="删除" onclick="delRow()" class="danger delMsg"><i class="fa fa-trash"></i></a>';
					s += '<a href="javascript:void(0);" title="编辑" onclick="editRow()" class="info"><i class="fa fa-pencil-square-o"></i></a></div>';
					return s;
				}
			} ] ]
		});
	}
</script>
</head>
<body scroll="no" class="body-pd10">
	<div class="dataView-container">
		<div class="table-container">
			<div class="tabs-wrapper">
				<div class="comp-search-box">
					<div class="screen-top">
						<div class="colRow">
							<input type="text" class="easyui-textbox" id="name" data-options="label:'姓名'" />
						</div>
						<div class="colRow">
							<select class="easyui-combobox" name="status" id="status" data-options="label:'状态'" style="vertical-align: top; width: 120px;">
								<option value=""></option>
								<option value="">全部</option>
								<option value="0">报名成功</option>
								<option value="1">考试通过</option>
								<option value="2">考试未通过</option>
								<option value="3">出证完成</option>
							</select>
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
</body>
</html>