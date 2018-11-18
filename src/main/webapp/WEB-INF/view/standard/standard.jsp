<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>考核标准</title>
<%@ include file="/common/taglibs.jsp"%>
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
				<table class="easyui-treegrid" data-options="
				url: 'treegrid_data1.json',
				method: 'get',
				rownumbers: true,
				idField: 'id',
				treeField: 'name'
			">
					<thead>
						<tr>
							<th data-options="field:'name'" width="50">分类</th>
							<th data-options="field:'size'" width="100" align="right">序号</th>
							<th data-options="field:'date'" width="350">考核标准</th>
							<th data-options="field:'date1'" width="150">计分标准</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</body>
</html>