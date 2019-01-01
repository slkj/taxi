﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>考试报名</title>
<%@ include file="/common/taglibs.jsp"%>
</head>
<body scroll="no" class="body-pd10">
	<div class="dataView-container">
		<div class="table-container">
			<div class="tabs-wrapper">
				<div class="comp-search-box">
					<div class="screen-top">
						<div class="colRow">
						<input type="hidden" name="company" id="company" value="${sessionUser.departName }" />
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
						<div class="colRow">
						<button class="easyui-linkbutton btnDefault" onclick="toExcel()">
								<i class="fa fa-download"></i>
								导出
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
	<!-- <div class="dig-wrapper" id="newData-wrapper">
		<div class="form1-column" title="表单示例">
			<form id="vui_sample" class="easyui-form">
				<input type="hidden" name="id">
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="username" style="width: 100%" data-options="label:'用户名称',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="realname" style="width: 100%" data-options="label:'姓名:',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input class="easyui-textbox" name="phone" style="width: 100%" data-options="label:'联系电话:',required:true">
					</div>
				</div>
				<div class="form-column1">
					<div class="form-column-left">
						<input id="unitnameCombox" class="easyui-combobox" name="departName" data-options="
									label:'单位',
									url: '../company/queryComList',
									valueField:'unitname',
									textField:'unitname'" style="width: 100%; height: 32px">
					</div>
				</div>
				<div class="form-btnBar pl75">
					<input type="submit" name="" value="保存" class="easyui-linkbutton btnPrimary" onclick="submitForm()" style="width: 80px" />
					<input type="submit" name="" value="重置" class="easyui-linkbutton btnDefault" onclick="clearForm()" style="width: 80px" />
				</div>
			</form>
		</div>
	</div> -->
	<script type="text/javascript">
		var $grid;
		var curUserComCode;
		$(function() {
			$grid = $("#list_data");
			initGrid();
			//新增数据
			$('#newData').on('click', function() {
				layer.open({
					type : 2,
					title : "报考信息",
					skin : 'layui-layer-rim', //加上边框
					area : [ '810px', '460px' ], //宽高
					content : 'goSignUpAdd',
					zIndex : 1000
				});
			});
			$('#queryData').on('click', function() {
				$grid.datagrid({
					queryParams : {
						name : $('#name').val(),
						status : $('#status').val(),
						company : $('#company').val()
					}
				});
			});
		});
		function initGrid() {
			//datagrid初始化 
			$grid.datagrid({
				url : 'slistPage',
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
			return [ [ {
				title : '姓名',
				field : 'name'
			}, {
				title : '性别',
				field : 'sex',
				formatter : function(value) {
					if (value == "0") {
						return "男";
					} else {
						return "女";
					}
				}
			}, {
				title : '身份证号',
				field : 'idcard'
			}, {
				title : '联系电话',
				field : 'phone'
			}, {
				title : '电话',
				field : 'phone'
			}, {
				title : '报名日期',
				field : 'addtime'
			}, {
				title : '状态',
				field : 'status',
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
			}, {
				field : 'opt',
				title : '操作',
				align : 'center',
				formatter : function(value, row) {
					var s = '<div class ="updateBtn">';
					s += '<a href="javascript:void(0);" title="删除"  onclick="delRow(\''+row.id+'\')" class="danger delMsg"><i class="fa fa-trash"></i></a>';
					s += ' <a href="javascript:void(0);" title="编辑" onclick="editRow(\''+row.id+'\')" class="info"><i class="fa fa-pencil-square-o"></i></a></div>';
					return s;
				}
			} ] ];
		}
		//修改
		function editRow(id) {
			//var row = $('#list_data').datagrid('getSelected');
			//if (row) {
				layer.open({
					type : 2,
					skin : 'layui-layer-rim', //加上边框
					hade : [ 0.5, '#000', false ],
					area : [ '810px', '460px' ], //宽高
					title : [ '报考信息', false ],
					content : 'goSignUpEdit?id=' + id
				});
			//}
		}
		//删除
		function delRow(id) {
			//var row = $('#list_data').datagrid('getSelected');
			//if (row) {
				$.messager.confirm('提示', '确定要删除该记录?', function(r) {
					if (r) {
						$.ajax({
							url : "delete?id=" + id,
							success : function(data) {
								if (data) {
									$grid.datagrid('reload');
								} else {
									showError("操作失败");
									msgShow('系统提示', '出现异常');
								}
							}
						});
					}
				});
			//}
		}
		//导出excel
		function toExcel(){
			 var name = $('#name').val();
			 var status = $('#status').val();
			 var company = $('#company').val();
			    window.location.href='goExcel?name='
						+encodeURI(encodeURI(name))
						+'&status='+encodeURI(encodeURI(status))
						+'&company='+encodeURI(encodeURI(company));  
			
		}
	</script>
</body>
</html>