﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>从业资格注销审核</title>
<%@ include file="/common/taglibs.jsp"%>
</head>
<body scroll="no" class="body-pd10">
	<div class="dataView-container">
		<div class="table-container">
			<div class="tabs-wrapper">
				<div class="comp-search-box">
					<div class="screen-top">
						<div class="colRow">
						<%-- <input type="hidden" name="company" id="company" value="${sessionUser.departName }" /> --%>
							<input type="text" class="easyui-textbox" id="name" data-options="label:'姓名'" />
						</div>
						<div class="colRow">
							<input type="text" class="easyui-textbox" id="cyzgCard" data-options="label:'从业资格证号'" />
						</div>
						<div class="colRow">
						<select class="easyui-combobox" name="status" id="status" data-options="label:'状态'" style="vertical-align: top; width: 120px;">
						<option value="">全部</option>
						<option value="0">待审核</option>
						<option value="1">待上级审批</option>
						<option value="2">审核未通过</option>
						<option value="3">审核通过</option>
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

	<script type="text/javascript">
		var $grid;
		var curUserComCode;
		$(function() {
			$grid = $("#list_data");
			initGrid();
			$('#queryData').on('click', function() {
				$grid.datagrid({
					queryParams : {
						name : $('#name').val(),
						cyzgCard : $('#cyzgCard').val(),
						status : $('#status').val()
					}
				});
			});
			//新增数据
			$('#newData').on('click', function(){
				layer.open({
					type : 2,
					skin : 'layui-layer-rim', //加上边框
					hade : [ 0.5, '#000', false ],
					area : [ '980px', '600px' ], //宽高
					title : [ '编辑信息', false ],
					content : 'goAdd'
				});
			});
		});
		function initGrid() {
			//datagrid初始化 
			$grid.datagrid({
				url : 'list',
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
			},{
				title : '出生年月',
				field : 'borndate'
			}, {
				title : '联系电话',
				field : 'phone'
			}, {
				title : '从业资格证号',
				field : 'old_sign_id'
			},  {
				title : '状态',
				field : 'status',
				formatter : function(value, row, index) {
					if (value == 0) {
						return '<div style="background-color:#7b6f6f;text-align:center;color:#FFFFFF;">待审核</div>';
					} else if (value == 1) {
						return '<div style="background-color:#4b4b4b;text-align:center;color:#FFFFFF;">待上级审批</div>';
					} else if (value == 2) {
						return '<div style="background-color:#3a87ad;text-align:center;color:#FFFFFF;">审核未通过</div>';
					} else if (value == 3) {
						return '<div style="background-color:#356635;text-align:center;color:#FFFFFF;">审核通过</div>';
					}
				}
			}, {
				field : 'opt',
				title : '操作',
				align : 'center',
				formatter : function(value, row) {
					var s = '<div class ="updateBtn">';
					s += '<a href="javascript:void(0);" title="删除"  onclick="delRow(\''+row.id+'\')" class="danger delMsg"><i class="fa fa-trash"></i></a></div>';
				    //s += ' <a href="javascript:void(0);" title="编辑" onclick="editRow(\''+row.id+'\')" class="info"><i class="fa fa-pencil-square-o"></i></a></div>';
					return s;
				}
			} ] ];
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
			 var cyzgCard = $('#cyzgCard').val();
			 var status = $('#status').val();
			 var company = $('#company').val();
			    window.location.href='goExcel?name='
						+encodeURI(encodeURI(name))
						+'&cyzgCard='+encodeURI(encodeURI(cyzgCard))
						+'&status='+encodeURI(encodeURI(status))
						+'&company='+encodeURI(encodeURI(company));     
			
		}
	</script>
</body>
</html>

