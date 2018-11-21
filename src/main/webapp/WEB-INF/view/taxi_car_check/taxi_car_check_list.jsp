<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>承德市出租汽车管理系统</title>
<%@ include file="/common/taglibs.jsp"%>
<script>
	var $grid;
	
	$(function() {
		$grid = $("#list_data");
		initGrid();

	});
	function initGrid() {
		//datagrid初始化 
		$grid.datagrid({
					url : '../taxicarCheck/checkList',
					iconCls : 'icon-site',
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
					frozenColumns : [ [						
							{
								width : 200,
								field : 'operatingnum',
								title : '营运证号'
							}, {
								width : 200,
								field : 'annualdate',
								title : '年审日期'
							}, {
								width : 200,
								field : 'nextannualdate',
								title : '终止日期'
							},  {
						field : 'status',
						title : '状态',
						width : 150,
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
					} , {
						field : 'opt',
						title : '操作',
						width : 150,
						align : 'center',
						formatter : function(value, row) {
							var s = "";
							s += "<a href=\"javascript:void(0)\" onclick=\"editRow('" + row.id + "','" + row.operatingnum + "');\"><i class=\"fa fa-pencil \"></i>编辑</a>";
							s += "|";
							s += "<a href=\"javascript:void(0)\" onclick=\"deleteRow('" + row.id + "');\"><i class=\"fa fa-times-rectangle danger\"></i>删除 </a>";
							return s;
						}
					}] ],					
					onLoadSuccess : function(data) {
						if (data && data.rows && data.rows.length > 0) {
							$grid.datagrid("clearSelections");
						} else {
							$grid.datagrid("clearSelections");
						}
					}

				});
	}

	function add() {
		self.location.href = getContextPath() + "/taxicarCheck/taxicarCheckEditPage";
	}
	function editRow(id,operatingnum) {		
		self.location.href = getContextPath()
				+ "/taxicarCheck/taxicarCheckEditPage?pkey=" + id+"&opr="+operatingnum;
	}
	
	function deleteRow(id) {
	if (confirm("确定要删除吗？")) {
			$.ajax({
				type : "POST",
				url : getContextPath() + '/taxicarCheck/deleteCheck',
				data : {
					id : id
				},
				cache : false,
				async : false,
				success : function(data) {
					$grid.datagrid('reload');
				}
			});
		}
	
	}
	

	function query() {
		
		$grid.datagrid({
			queryParams : {
				operatingnum : $('#operatingnum').val()
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
					<input type="text" class="easyui-textbox" id="operatingnum" data-options="label:'营运证号'" />
				</div>
				<div class="colRow">
					<button class="easyui-linkbutton btnDefault" onclick="query()">
						<i class="fa fa-search"></i> 查询
					</button>
				</div>
			</div>
		</div>
		<div class="btnbar-tools">
			<a href="javascript:;" class="add" onclick="add()"> <i class="fa fa-plus-square success "></i> 添加
			</a> 
		</div>
	</div>
	<div data-options="region:'center',border:true">
		<table id=list_data data-options="fit:true,border:false"></table>
	</div>
</body>
</html>
