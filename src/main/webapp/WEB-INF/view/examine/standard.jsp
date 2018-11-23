<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>考核标准</title>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
	$(function() {
		// 		$('#tt').treegrid({
		// 			url : '../standard/standard/all',
		// 			idField : 'id', //定义标识树节点的键名字段
		// 			treeField : 'ordinal', //定义树节点的字段
		// 			pagination : false,// 显示分页
		// 			fitColumns : true, //设置为 true，则会自动扩大或缩小列的尺寸以适应网格的宽度并且防止水平滚动。
		// 			columns : [ [ {
		// 				field : 'id',
		// 				title : '分类',
		// 				width : 100
		// 			}, {
		// 				field : 'ordinal',
		// 				title : '序号',
		// 				width : 100
		// 			}, {
		// 				field : 'standard',
		// 				title : '考核标准',
		// 				width : 100
		// 			}, {
		// 				field : 'scoring',
		// 				title : '计分标准',
		// 				width : 100
		// 			} ] ]
		// 		});
	});
</script>
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
				<table id="tg" class="easyui-treegrid"    data-options="
                iconCls: 'icon-ok',
                rownumbers: true,
                animate: true,
                collapsible: true,
                fitColumns: true,
                url: '../assets/treegrid_data2.json',
                method: 'get',
                idField: 'id',
                treeField: 'name'
            ">
					<thead>
						<tr>
							<th data-options="field:'name',width:180">分类</th>
							<th data-options="field:'persons',width:60,align:'right'">考核标准</th>
							<th data-options="field:'begin',width:80">计分标准</th>
							<th data-options="field:'end',width:80">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>

	<!-- 	<table id="table_report" class="table table-striped table-bordered table-hover"> -->
	<!-- 		<thead> -->
	<!-- 			<tr> -->
	<!-- 				<th class="center" style="width: 50px;">分类</th> -->
	<!-- 				<th class='center'>考核标准</th> -->
	<!-- 				<th class='center'>计分标准</th> -->
	<!-- 				<th class='center'>操作</th> -->
	<!-- 			</tr> -->
	<!-- 		</thead> -->
	<%-- 		<c:choose> --%>
	<%-- 			<c:when test="${not empty standardList}"> --%>
	<%-- 				<c:forEach items="${standardList}" var="sl" varStatus="vs"> --%>
	<!-- 					<tr> -->
	<%-- 						<td class="center" style="width: 60px;">${sl.ordinal }</td> --%>
	<%-- 						<td>${sl.standard }</td> --%>
	<%-- 						<td  style="width: 80px;text-align: center;">${sl.scoring }</td> --%>
	<!-- 						<td style="width: 160px;"></td> -->
	<!-- 					</tr> -->
	<%-- 				</c:forEach> --%>
	<%-- 			</c:when> --%>
	<%-- 			<c:otherwise> --%>
	<!-- 				<tr> -->
	<!-- 					<td colspan="100">没有相关数据</td> -->
	<!-- 				</tr> -->
	<%-- 			</c:otherwise> --%>
	<%-- 		</c:choose> --%>
	<!-- 	</table> -->
</body>
</html>