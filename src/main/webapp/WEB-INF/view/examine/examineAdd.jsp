<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
	//检索
	function search() {
		$("#employeeForm").submit();
	}
	$(function() {
		$("#click_event, .closeForm").click(function() {
			// 			$("#form-wrapper").slideToggle(1000);
			layer.open({
				type : 1,
				skin : 'layui-layer-rim', //加上边框
				area : [ '490px', '450px' ], //宽高
				content : $('#newData-wrapper'),
				zIndex : 1000
			});
		});
	});
</script>
</head>
<body scroll="no" class="body-pd10">
	<div class="dataView-container">
		<div class="table-container">
			<div class="tabs-wrapper">
				<form action="../examine/examineAdd" method="post" name="employeeForm" id="employeeForm">
					<div class="comp-search-box">
						<div class="screen-top">
							<div class="colRow">
								<input class="easyui-textbox" name="idcard" style="width: 300px">
								<input type="button" value="查询" class="easyui-linkbutton btnPrimary" style="width: 100px" onclick="search();" />
							</div>
						</div>
						<div class="screen-term" style="display: block;">
							<c:choose>
								<c:when test="${not empty employee}">
									<div class="form2-column" style="margin: 0px 0px 0px 10px;">
										<div class="form-column2">
											<div class="form-column-left">
												<input class="easyui-textbox" style="width: 100%" data-options="label:'姓名:'" value="${employee.name }" editable="false">
											</div>
											<div class="form-column-left fm-left">
												<input class="easyui-textbox" style="width: 100%" data-options="label:'身份证号:'" value="${employee.idcard }" editable="false">
											</div>
										</div>
										<div class="form-column2">
											<div class="form-column-left">
												<input class="easyui-textbox" style="width: 100%" data-options="label:'从业资格证号:'" value="${employee.cyzgCard }" editable="false">
											</div>
											<div class="form-column-left fm-left">
												<input class="easyui-textbox" style="width: 100%" data-options="label:'注册车牌号:'" value="${employee.carid }" editable="false">
											</div>
										</div>
										<div class="form-column2">
											<div class="form-column-left">
												<input class="easyui-textbox" style="width: 100%" data-options="label:'所属公司:'" value="${employee.company }" editable="false">
											</div>
											<div class="form-column-left fm-left">
												<input class="easyui-textbox" style="width: 100%" data-options="label:'剩余分数:'" value="${syFraction}" editable="false">
											</div>
										</div>
										<div class="form-column2">
											<div class="form-column-left">
												<input id="click_event" type="button" value="扣分登记" class="easyui-linkbutton btnPrimary" style="width: 100px" />
											</div>
										</div>
									</div>
								</c:when>
							</c:choose>
						</div>
					</div>
					<c:choose>
						<c:when test="${not empty employee}">
							<table class="easyui-datagrid" title="考核记录">
								<thead>
									<tr>
										<th field=ordinal width="45%" align="left">扣分条款</th>
										<th field="scoring" width="5%" align="center">扣分分数</th>
										<th field="examineTime" width="5%" align="center">扣分时间</th>
										<th field="remark" width="150px" align="left">备注</th>
										<th field="opt" width="150px" align="left"></th>
									</tr>
								</thead>
								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty staList}">
											<c:forEach items="${staList}" var="var" varStatus="vs">
												<tr>
													<td align="left">${var.ordinal }</td>
													<td>${var.scoring }</td>
													<td>${var.examineTime }</td>
													<td align="left">${var.remark }</td>
													<td></td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr class="main_info">
												<td colspan="100" class="center">没有相关数据</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</c:when>
					</c:choose>
				</form>
			</div>
		</div>
	</div>
	<div class="dig-wrapper" id="newData-wrapper">
		<div class="form1-column" title="表单示例">
			<form id="vui_sample" class="easyui-form" method="post" data-options="novalidate:true">
				<div class="form-column1">
					<div class="form-column1">
						<div class="form-column-left">
							<select class="easyui-combobox" name="state" data-options="label:'扣分条款:',required:true" labelPosition="top" style="width: 100%;">
								<option value="AL">新增</option>
								<option value="AK">已提交</option>
								<option value="AZ">申请中</option>
								<option value="AR">已入库</option>
							</select>
						</div>
					</div>
					<div class="form-column1">
						<div class="form-column-left">
							<input class="easyui-textbox" name="name" style="width: 100%" data-options="label:'扣分分数:',required:true">
						</div>
					</div>
					<div class="form-column1">
						<div class="form-column-left">
							<input class="easyui-textbox" name="name" style="width: 100%" data-options="label:'扣分时间',required:true">
						</div>
					</div>
					<div class="form-column1">
						<div class="form-column-left">
							<input class="easyui-textbox" name="message" style="width: 100%; height: 60px" data-options="label:'备注:',multiline:true">
						</div>
					</div>
					<div class="form-btnBar pl75">
						<input type="submit" name="" value="保存" class="easyui-linkbutton btnPrimary" onclick="submitForm()" style="width: 80px" />
						<input type="submit" name="" value="重置" class="easyui-linkbutton btnDefault" onclick="clearForm()" style="width: 80px" />
					</div>
			</form>
		</div>
	</div>
</body>
</html>