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
<script src="${pageContext.request.contextPath}/assets/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/My97DatePicker/skin/WdatePicker.css">
<script type="text/javascript">
	//检索
	function search() {
		$("#employeeRegisterForm").submit();
	}
	function submitForm() {
		var validate = $("#vui_sample").form('validate');
		if (!validate) {
			return validate;
		}
		//var formData = new FormData(document.getElementById("vui_sample"));
		var data =$("#vui_sample").serializeArray();
		$.ajax({
			url : "save",
			type : "POST",
			data : data,
			async : false,
			cache : false,
			success : function(res) {
				if (res) {
					var index = parent.layer.getFrameIndex(window.name);
					parent.layer.close(index);
					parent.$('#list_data').datagrid('reload');
				} else {
					msgShow('系统提示', '出现异常');
				}
			}
		});

		return false;
	}
	function clearForm() {//重置表单
		//$('#vui_sample').form('clear');
		var index = parent.layer.getFrameIndex(window.name);
		parent.layer.close(index);
	}
</script>
</head>
<body scroll="no" class="body-pd10">
	<div class="dataView-container">
		<div class="table-container">
			<div class="tabs-wrapper">
				
			<div class="comp-search-box">
			<form action="../changeCompany/goAdd" method="post" name="employeeRegisterForm" id="employeeRegisterForm">
				<div class="screen-top">
					<div class="colRow">
						<input class="easyui-textbox" name="idcard" style="width: 300px">
			<input type="button" value="查询" class="easyui-linkbutton btnPrimary" style="width: 100px" onclick="search();" />
				</div>
			</div>
			</form>
			<form method="post" id="vui_sample">
			<input type="hidden" name="id" id="id" value="${pd.id }" />
			
			<c:if test="${msg == 'save'}">
			<input type="hidden" name="status" id="status" value="0" />
			</c:if>
			<div class="screen-term" style="display: block;">
			<c:choose>
			<c:when test="${not empty employee}">
			<input type="hidden" name="old_company" id="old_company" value="${employee.company }" />
				<div class="form2-column" style="margin: 0px 0px 0px 10px;">
					<div class="form-column2">
						<div class="form-column-left">
							<input class="easyui-textbox" style="width: 100%" name="name" data-options="label:'姓名:'" value="${employee.name }" editable="false">
						</div>
						<div class="form-column-left fm-left">
							<select  class="easyui-combobox" style="width: 80px;" name="sex"  data-options="label:'性别:'" editable="false">
								<option value='0' <c:if test="${employee.sex == '0' }">selected</c:if>>男</option>
								<option value='1' <c:if test="${employee.sex == '1' }">selected</c:if>>女</option>
							</select>
						</div>
						<div class="form-column2">
						<div class="form-column-left">
							<input class="easyui-textbox" style="width: 100%" name="cyzg_card" data-options="label:'从业资格证号:'" value="${employee.cyzgCard }" editable="false">
						</div>										
						<div class="form-column-left fm-left">
							<input class="easyui-textbox" style="width: 100%" name="idcard" data-options="label:'身份证号:'" value="${employee.idcard }" editable="false">
						</div>
						</div>
										
						<div  class="form-btnBar pl75">
							<input type="submit" value="申请变更为本公司人员" class="easyui-linkbutton btnPrimary" onclick="submitForm()"
							style="width: 150px" /> 
							<input type="submit" value="取消" class="easyui-linkbutton btnDefault"
							onclick="clearForm()" style="width: 80px" />
						</div>
					</div>
				</div>
			</c:when>
			</c:choose>
				</div>
				</form>
			</div>
		</div>
	</div>
</div>

</body>
</html>