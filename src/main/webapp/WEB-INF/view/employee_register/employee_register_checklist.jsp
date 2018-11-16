<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">

	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	
	</head> 

<body>
		
		
<div class="container-fluid" id="main-container">

		

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">


	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="employeeRegister/checklist.do" method="post" name="userForm" id="userForm">
			<table border='0'>
				<tr>
				
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="title" value="${pd.title }" placeholder="这里关键词" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td>
					<%-- <td style="vertical-align:top;"> 
					 	<select class="chzn-select" name="status" id="status" data-placeholder="请选择状态" style="vertical-align:top;width: 120px;">
						<option value=""></option>
						<option value="">全部</option>
						<option value="0" <c:if test="${pd.status=='0'}">selected</c:if>>待审核</option>
						<option value="1" <c:if test="${pd.status=='1'}">selected</c:if>>审核未通过</option>
						<option value="2" <c:if test="${pd.status=='2'}">selected</c:if>>审核通过</option>
					  	</select>
					</td> --%>
					
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"><i id="nav-search-icon" class="icon-search"></i></button></td>
					
				</tr>
			</table>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr>
						<th class="center" onclick="selectAll()">
							<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th>
						<th class='center' >编号</th>
						<th class='center' >档案号</th>
						<th class='center' >姓名</th>
						<th class='center' >性别</th>
						<th class='center' >从业资格证号</th>
						<th class='center' >车号</th>
						<th class='center' >车型</th>
						<th class='center' >申请时间</th>
						<!-- <th class='center' >状态</th> -->
						<th class="center">操作</th>
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty varList}">
						<c:if test="${QX.cha == 1 }">
						<c:forEach items="${varList}" var="var" varStatus="vs">
									
							<tr>
								<td class='center' style="width: 30px;">
									<label><input type='checkbox' name='ids' value="${var.ID }" id="${var.ID }"/><span class="lbl"></span></label>
								</td>
								<td class='center' >${var.ID}</td>
								<td class='center' >${var.PERSONAL_ID}</td>
								<td class='center' >${var.NAME}</td>
								<td class='center' >
									<c:if test="${var.SEX == 0 }">男</c:if>
									<c:if test="${var.SEX == 1 }">女</c:if>
								</td>
								<td class='center' >${var.CYZG_CARD }</td>
								<td class='center' >${var.CARID }</td>
								<td class='center' >${var.CARTYPE }</td>
								<td class='center' >${var.ADDTIME }</td>
								<%-- <td class='center' >
									<c:if test="${var.STATUS == 0 }"><span class="label label-danger">待审核</span></c:if>
									<c:if test="${var.STATUS == 1 }"><span class="label label-fail">审核失败</span></c:if>
									<c:if test="${var.STATUS == 2 }"><span class="label label-success">审核成功</span></c:if>
								</td> --%>
								<td style="width: 60px;" class="center">
									<div class='btn-group'>
										<a class='btn btn-mini btn-yellow' title="查看" onclick="show('${var.ID }');"><i class='icon-eye-open'></i></a>
										<c:if test="${QX.del == 1 }">
										 	<a class='btn btn-mini btn-danger' title="删除" onclick="del('${var.ID }');"><i class='icon-trash'></i></a>
										</c:if>
									</div>
								</td>
							</tr>
						
						</c:forEach>
						</c:if>
						
						<c:if test="${QX.cha == 0 }">
							<tr>
								<td colspan="100" class="center">您无权查看</td>
							</tr>
						</c:if>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="100" class="center" >没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
			
		<div class="page-header position-relative">
		<table style="width:100%;">
			<tr>
				<c:if test="${QX.add == 1 }">
				<td style="vertical-align:top;">
					<%-- <a class="btn btn-small btn-success" onclick="add();">新增</a>
					<c:if test="${pd.status=='0'}">
						<a class="btn btn-small btn-yellow" onclick="makeAll('确定要审核选中信息吗?');">审核</a>
					</c:if> --%>
					<%-- <c:if test="${pd.status=='2'}"> --%>
						<!-- <a class="btn btn-small btn-info" onclick="makeAll('确定要打印监督卡吗?');">打印监督卡</a> -->
					<%-- </c:if> --%>
				</td>
				</c:if>
				<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
			</tr>
		</table>
		</div>
		</form>
	</div>
 
 
 
 
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
	
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
		
		<!-- 返回顶部  -->
		<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
			<i class="icon-double-angle-up icon-only"></i>
		</a>
		
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 单选框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		
		<script type="text/javascript">
		
		$(top.hangge());
		
		//检索
		function search(){
			$("#Form").submit();
		}
		
		//全选 （是/否）
		function selectAll(){
			 var checklist = document.getElementsByName ("ids");
			   if(document.getElementById("zcheckbox").checked){
			   for(var i=0;i<checklist.length;i++){
			      checklist[i].checked = 1;
			   } 
			 }else{
			  for(var j=0;j<checklist.length;j++){
			     checklist[j].checked = 0;
			  }
			 }
		}
		
		//删除
		function del(id){
			bootbox.confirm("确定要删除该记录?", function(result) {
				if(result) {
					var url = "<%=basePath%>employeeRegister/delete.do?id="+id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						if(data=="success"){
							nextPage(${page.currentPage});
						}
					});
				}
			});
		}
		
		//新增
		function add(){
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>employeeRegister/goAdd.do';
			 diag.Width = 820;
			 diag.Height = 580;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location.reload()",100);
					 }else{
						 nextPage(${page.currentPage});
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//审核
		function show(id){
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="注册审核";
			 diag.URL = '<%=basePath%>employeeRegister/goCheck.do?id='+id;
			 diag.Width = 820;
			 diag.Height = 450;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location.reload()",100);
					 }else{
						 nextPage(${page.currentPage});
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
		function printRegister(str){
			var url = "<%=basePath%>employeeRegister/printEmployeeRegister.do?E_IDS="+str;
			window.open(url);
		}
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					var emstr = '';
					var phones = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(str=='') str += document.getElementsByName('ids')[i].value;
						  	else str += ',' + document.getElementsByName('ids')[i].value;
						  	
						  	if(emstr=='') emstr += document.getElementsByName('ids')[i].id;
						  	else emstr += ';' + document.getElementsByName('ids')[i].id;
						  	
						  	if(phones=='') phones += document.getElementsByName('ids')[i].alt;
						  	else phones += ';' + document.getElementsByName('ids')[i].alt;
						  }
					}
					if(str==''){
						bootbox.dialog("您没有选择任何内容!", 
							[
							  {
								"label" : "关闭",
								"class" : "btn-small btn-success",
								"callback": function() {
									}
								}
							 ]
						);
						
						$("#zcheckbox").tips({
							side:3,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						
						return;
					}else{
						if(msg == '确定要审核选中信息吗?'){
							var arr = str.split(",");
							$.each(arr, function(idx, obj) {
								var url = "<%=basePath%>employeeRegister/checkAllRegister.do?id="+obj+"&status=2"+"&tm="+new Date().getTime();
								$.get(url,function(data){
									if(data=="error"){
										bootbox.alert("编号为\""+obj+"\"审核失败，请联系管理员");
									}else if(data=="useReg"){
										bootbox.alert("编号为\""+obj+"\"该从业人员已注册！");
									}else if(data=="carerr"){
										bootbox.alert("编号为\""+obj+"\"所注册车辆已超过三人！");
									}else if(data=="success"){
										window.location.reload();
									}
								});
							});
							
						}else if(msg == '确定要打印监督卡吗?'){
							var url = "<%=basePath%>employeeRegister/printAllSupervisionCard.do?E_IDS="+str;
							window.open(url);
						}
						
					}
				}
			});
		}
		
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			
		});
		
		
		</script>
		
	</body>
</html>

