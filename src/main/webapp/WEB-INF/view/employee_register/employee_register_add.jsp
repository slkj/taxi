<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		
		<meta charset="utf-8" />
		<title></title>
		
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<link rel="stylesheet" href="static/css/chosen.css" />
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<style type="text/css">
		body{
			overflow-x: hidden;
		}
		</style>
		
		<!-- Attach our CSS -->
	  	<link rel="stylesheet" href="static/css/reveal.css">	
	  	
		<!-- Attach necessary scripts -->
		<script type="text/javascript" src="static/js/jquery.reveal.js"></script>
		
		<style type="text/css">
			body { font-family: "HelveticaNeue","Helvetica-Neue", "Helvetica", "Arial", sans-serif; }
			.big-link { display:block; margin-top: 100px; text-align: center; font-size: 70px; color: #06f; }
		</style>
		
		<script type="text/javascript">
			
			//保存
			function save(){
				if($("#sex").val() == "0") {
					if(ages($("#borndate").val()) >= 60 ) {
						alert("人员超龄！");
						return false;
					}
				}else {
					if(ages($("#borndate").val()) >= 55 ) {
						alert("人员超龄！");
						return false;		
					}
				}
				$(top.jzts());
				var cyzgCard = $("#cyzgCard").val();
				var url = "<%=basePath%>employeeRegister/hashEmpCar.do?cyzgCard="+cyzgCard+"&tm="+new Date().getTime();
				$.get(url,function(data){
					$(top.hangge());
					if(data=="error"){
						alert("该人已注册过，若要重新注册，请先注销！");
						return false;
					}else if(data=="success"){
						$(top.jzts());
						var carid = $("#carid").val();
						var url = "<%=basePath%>employeeRegister/hasEmp3.do?carid="+carid+"&tm="+new Date().getTime();
						$.get(url,function(data){
							$(top.hangge());
							var obj = jQuery.parseJSON(data); 
							if(obj.status == "error"){
								var console = "";
								$.each(obj.list, function(i, item){      
										console += "姓名:" + item.NAME;
										console += "&nbsp;&nbsp;|&nbsp;&nbsp;性别:" + ((item.SEX = 1) ? "男" : "女");
										console += "&nbsp;&nbsp;|&nbsp;&nbsp;身份证号:" + item.IDCARD;
										console += "&nbsp;&nbsp;|&nbsp;&nbsp;手机:" + item.PHONE + "<br>";
									});
								$("#alert_btn").click(); 
								$("#title")[0].innerHTML = "该车已超过三人,无法注册!";
								$("#alert_pages")[0].innerHTML = console;
							}else if(obj.status=="success"){
								$("#FormSave").submit();
								$("#zhongxin").hide();
								$("#zhongxin2").show();
							}
						});
					}
				}); 
			}
			

			function ages(str) {
				var r = str.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
				if (r == null)
					return false;
				var d = new Date(r[1], r[3] - 1, r[4]);
				if (d.getFullYear() == r[1] && (d.getMonth() + 1) == r[3]
						&& d.getDate() == r[4]) {
					var Y = new Date().getFullYear();
					return (Y - r[1]);
				}
				return "系统错误，请检查该人员出生年月是否正常";
			}
			
			//检索
			function search() {
				$("#Form").submit();
			}
		</script>
	</head>
<body>
		<a href="#" id="alert_btn" data-reveal-id="myModal" data-animation="fade"></a>
		<div id="myModal" class="reveal-modal">
			<h1 id="title"></h1>
			<p id="alert_pages"></p>
			<a class="close-reveal-modal">&#215;</a>
		</div>
		
	<div style="margin-top: 20px;" id="zhongxin">
		<form class="form-horizontal" action="employeeRegister/goAdd.do"
			name="Form" id="Form" method="post">
			<table id="table_report"
				class="table table-striped table-bordered table-hover">
				<tr>
					<td><span style="margin-left: 20px;">请输入要注册人员的信息关键词：</span> <span
						class="input-icon" style="margin-left: 10px;"> <input
							autocomplete="off" id="nav-search-input" type="text" name="title"
							value="${pd.title }" style="width: 200px;" placeholder="这里关键词" />
							<i id="nav-search-icon" class="icon-search"></i>
							<button class="btn btn-mini btn-light" onclick="search();">
								<i id="nav-search-icon" class="icon-search"></i>
							</button>
					</span></td>
				</tr>
			</table>
		</form>

		<table style="table-layout: fixed;" id="table_report" border="1"
			class="table table-striped table-bordered table-hover">
			<c:choose>
				<c:when test="${employee.size() == 1}">
					<tr>
						<td colspan="4"><span style="margin-left: 20px;">从业资格证号：</span>
							<span style="margin-left: 2px;">${employee[0].CYZG_CARD }</span></td>
						<td colspan="4"><span style="margin-left: 10px;">身份证号码：</span>
							<span style="margin-left: 2px;">${employee[0].IDCARD }</span></td>
					</tr>
					<tr>
						<td colspan="2"><span style="margin-left: 20px;">姓名：</span> <span
							style="margin-left: 2px;">${employee[0].NAME }</span></td>
						<td colspan="2"><span style="margin-left: 10px;">性别：</span> <span
							style="margin-left: 2px;"> <c:if
									test="${employee[0].SEX == 0 }">男</c:if> <c:if
									test="${employee[0].SEX == 1 }">女</c:if>
						</span></td>
						<td colspan="4"><span style="margin-left: 10px;">出生年月：</span>
							<span style="margin-left: 2px;">${employee[0].BORNDATE }</span></td>
					</tr>
					<tr>
						<td colspan="3"><span style="margin-left: 20px;">联系电话：</span>
							<span style="margin-left: 2px;">${employee[0].PHONE }</span></td>
						<td colspan="5"><span style="margin-left: 10px;">住址：</span> <span
							style="margin-left: 2px;">${employee[0].ADDRESS }</span></td>
					</tr>
					<tr>
						<td colspan="4"><span style="margin-left: 20px;">驾驶证号：</span>
							<span style="margin-left: 2px;">${employee[0].DRIVE_CARD }</span>
						</td>
						<td colspan="4"><span style="margin-left: 10px;">驾驶证初领日期：</span>
							<span style="margin-left: 2px;">${employee[0].DRIVE_START_DATE }</span>
						</td>
					</tr>
					
					<form class="form-horizontal" action="employeeRegister/save.do" name="FormSave" id="FormSave" method="post">
						<input type="hidden" name="cyzgCard" id="cyzgCard" value="${employee[0].CYZG_CARD }"/>
						<input type="hidden" name="idcard" id="idcard" value="${employee[0].IDCARD }"/>
						<input type="hidden" name="name" id="name" value="${employee[0].NAME }"/>
						<input type="hidden" name="sex" id="sex" value="${employee[0].SEX }"/>
						<input type="hidden" name="borndate" id="borndate" value="${employee[0].BORNDATE }"/>
						<input type="hidden" name="phone" id="phone" value="${employee[0].PHONE }"/>
						<input type="hidden" name="address" id="address" value="${employee[0].ADDRESS }"/>
						<input type="hidden" name="driveCard" id="driveCard" value="${employee[0].DRIVE_CARD }"/>
						<input type="hidden" name="driveStartDate" id="driveStartDate" value="${employee[0].DRIVE_START_DATE }"/>
						<input type="hidden" name="status" id="status" value="2"/>
						<table id="table_report" class="table table-striped table-bordered table-hover">
						<tr>
							<td colspan="4">
								<span style="margin-left: 20px;">车号：</span>
								<span style="margin-left: 2px;"><input id="carid" name="carid" value="${pd.CARID }" style="width:190px;" type="text" onblur="hashEMP3()"></span>
							</td>
							<td colspan="4">
								<span style="margin-left: 10px;">车型：</span>
								<span style="margin-left: 2px;"><input id="cartype" name="cartype" value="${pd.CARTYPE }" style="width:190px;" type="text"></span>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<span style="margin-left: 20px;">与经营者关系：</span> 
								<span style="margin-left: 2px;">
									<select style="width:150px;" id="engageConn" name="engageConn" title="ENGAGE_CONN">
										<option value="0" <c:if test="${pd.ENGAGE_CONN == 0 }">selected="selected"</c:if>>车主</option>
										<option value="1" <c:if test="${pd.ENGAGE_CONN == 1 }">selected="selected"</c:if>>雇佣</option>
									</select>
								</span>
							</td>
							<td colspan="4">
								<span style="margin-left: 10px;">经营时间：</span> 
								<span style="margin-left: 2px;"> 
									<select style="width:180px;" id="engageTime" name="engageTime" title="ENGAGE_TIME">
										<option value="0" <c:if test="${pd.ENGAGE_TIME == 0 }">selected="selected"</c:if>>白</option>
										<option value="1" <c:if test="${pd.ENGAGE_TIME == 1 }">selected="selected"</c:if>>夜</option>
										<option value="2" <c:if test="${pd.ENGAGE_TIME == 2 }">selected="selected"</c:if>>白夜</option>
									</select>
								</span>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<span style="margin-left: 20px;">承包起始时间：</span> 
								<span style="margin-left: 2px;">
									<input class="input-small input-mask-date" id="contractStrcount" name="contractStrcount" value="${pd.CONTRACT_STRCOUNT }" style="width:135px;" type="text">
								</span>
							</td>
							<td colspan="4">
								<span style="margin-left: 10px;">承包结束时间：</span> 
								<span style="margin-left: 2px;"> 
									<input class="input-small input-mask-date" id="contractEndcount" name="contractEndcount" value="${pd.CONTRACT_ENDCOUNT }" style="width:135px;" type="text">
								</span>
							</td>
						</tr>
						<tr>
							<td class="center" colspan="8">
								<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
								<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
							</td>
						</tr>
						</table>
					</form>
					
				</c:when>
				<c:otherwise>
					<tr class="main_info">
						<td colspan="8" class="center">没有相关数据</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>

	</div>
	<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
	
	
	
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 单选框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/jquery.maskedinput.min.js"></script>
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->

		<script type="text/javascript">
		$(top.hangge());
		$(function() {
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			$('.input-mask-date').mask('9999-99-99');
		});
		
		//判断编码一辆车是否大于三人
		function hashEMP3(){
			var carid = $("#carid").val();
			var url = "<%=basePath%>employeeRegister/hasEmp3.do?carid="+carid+"&tm="+new Date().getTime();
			$.get(url,function(data){
				var obj = jQuery.parseJSON(data); 
				if(obj.status == "error"){
					var console = "";
					$.each(obj.list, function(i, item){      
							console += "姓名:" + item.NAME;
							console += "&nbsp;&nbsp;|&nbsp;&nbsp;性别:" + ((item.SEX = 1) ? "男" : "女");
							console += "&nbsp;&nbsp;|&nbsp;&nbsp;身份证号:" + item.IDCARD;
							console += "&nbsp;&nbsp;|&nbsp;&nbsp;手机:" + item.PHONE + "<br>";
						});
					$("#alert_btn").click(); 
					$("#title")[0].innerHTML = "该车已超过三人,无法注册!";
					$("#alert_pages")[0].innerHTML = console;
				}else{
					var console = "";
					$.each(obj.list, function(i, item){      
							console += "姓名:" + item.NAME;
							console += "&nbsp;&nbsp;|&nbsp;&nbsp;性别:" + ((item.SEX = 1) ? "男" : "女");
							console += "&nbsp;&nbsp;|&nbsp;&nbsp;身份证号:" + item.IDCARD;
							console += "&nbsp;&nbsp;|&nbsp;&nbsp;手机:" + item.PHONE + "<br>";
						});
					$("#alert_btn").click(); 
					$("#title")[0].innerHTML = "该车共有"+ obj.list.length + "人,可继续注册";
					$("#alert_pages")[0].innerHTML = console;
					}
				});
			}
		</script>
	
</body>
</html>