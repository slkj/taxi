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
		<style>
			/*a  upload */
			.a-upload {
			    padding: 4px 10px;
			    height: 6px;
			    width:98px;
			    line-height: 6px;
			    position: relative;
			    cursor: pointer;
			    color: #888;
			    background: #fafafa;
			    border: 1px solid #ddd;
			    border-radius: 4px;
			    overflow: hidden;
			    display: inline-block;
			    *display: inline;
			    *zoom: 1
			}
			
			.a-upload  input {
			    position: absolute;
			    font-size: 100px;
			    right: 0;
			    top: 0;
			    opacity: 0;
			    filter: alpha(opacity=0);
			    cursor: pointer
			}
			
			.a-upload:hover {
			    color: #444;
			    background: #eee;
			    border-color: #ccc;
			    text-decoration: none
			}
			
		</style>
		<script type="text/javascript">
		
			//保存
			function save(){
				if($.trim($("#name").val()) ==""){
					
					$("#name").tips({
						side:3,
			            msg:'请输入姓名',
			            bg:'#AE81FF',
			            time:2
			        });
					
					$("#name").focus();
					return false;
				}else if($("#sex").val()==""){
					
					$("#sex").tips({
						side:3,
			            msg:'请输入性别',
			            bg:'#AE81FF',
			            time:2
			        });
					
					$("#sex").focus();
					return false;
				}else if(IsValidDate($("#borndate").val())){
					$("#borndate").tips({
						side:3,
			            msg:'请输入正确的出生日期',
			            bg:'#AE81FF',
			            time:2
			        });
					
					$("#borndate").focus();
					return false;
				}else if($.trim($("#nationality").val())==""){
					
					$("#nationality").tips({
						side:3,
			            msg:'请输入国籍',
			            bg:'#AE81FF',
			            time:2
			        });
					
					$("#nationality").focus();
					return false;
				}else if(!isCardNo($("#idcard").val())){
					
					$("#idcard").tips({
						side:3,
			            msg:'请输入正确的身份证号码',
			            bg:'#AE81FF',
			            time:2
			        });
					
					$("#idcard").focus();
					return false;
				}else if($.trim($("#educated").val())==""){
					
					$("#educated").tips({
						side:3,
			            msg:'请输入文化程度',
			            bg:'#AE81FF',
			            time:2
			        });
					
					$("#educated").focus();
					return false;
				}else if($.trim($("#phone").val())==""){
					
					$("#phone").tips({
						side:3,
			            msg:'请输入联系方式',
			            bg:'#AE81FF',
			            time:2
			        });
					
					$("#phone").focus();
					return false;
				}else if($("#infoPages").val()==""){
					
					$("#infoPages").tips({
						side:3,
			            msg:'请输入申报材料页数，如没有请输入0',
			            bg:'#AE81FF',
			            time:2
			        });
					
					$("#infoPages").focus();
					return false;
				}else if($.trim($("#driveCard").val())==""){
					
					$("#driveCard").tips({
						side:3,
			            msg:'请输入驾驶证号',
			            bg:'#AE81FF',
			            time:2
			        });
					
					$("#driveCard").focus();
					return false;
				}else if(IsValidDate($("#driveStartDate").val())){
					$("#driveStartDate").tips({
						side:3,
			            msg:'请输入正确的驾驶证初领日期',
			            bg:'#AE81FF',
			            time:2
			        });
					
					$("#driveStartDate").focus();
					return false;
				}else if($("#address").val()==""){
					
					$("#address").tips({
						side:3,
			            msg:'请输入住址',
			            bg:'#AE81FF',
			            time:2
			        });
					
					$("#address").focus();
					return false;
				}else if($("#driveType").val()==""){
					
					$("#driveType").tips({
						side:3,
			            msg:'请输入准驾车型',
			            bg:'#AE81FF',
			            time:2
			        });
					
					$("#driveType").focus();
					return false;
				}else{
					bootbox.confirm('请确认信息是否正确！！！提交后不可修改，若要返回修改请点击取消按钮！！', function(result) {
						if(result) {
							$("#Form").submit();
							$("#zhongxin").hide();
							$("#zhongxin2").show();
						}
					})
				}
			}
			
			function IsValidDate(DateStr) {
				var sDate = DateStr.replace(/(^\s+|\s+$)/g, '');//去两边空格; 
				if (sDate == '') {
					return true;
				}
				var s = sDate.replace(/[\d]{ 4,4 }[\-/]{1}[\d]{1,2}[\-/]{1}[\d]{1,2}/g, '');
				if (s == '') {
					var t = new Date(sDate.replace(/\-/g, '/'));
					var ar = sDate.split(/[-/:]/);
					if (ar[0] != t.getYear() || ar[1] != t.getMonth() + 1 || ar[2] != t.getDate()) {
						var r = DateStr.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
						var d= new Date(r[1], r[3]-1, r[4]);
						return !(d.getFullYear()==r[1]&&(d.getMonth()+1)==r[3]&&d.getDate()==r[4]);
					}
				} else {
					var r = DateStr.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
					var d= new Date(r[1], r[3]-1, r[4]);
					return !(d.getFullYear()==r[1]&&(d.getMonth()+1)==r[3]&&d.getDate()==r[4]);
				}
				
			}
			
			function isCardNo(card) { 
				 var pattern = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/; 
				 return pattern.test(card); 
			} 
		</script>
	</head>
<body>
	<form class="form-horizontal" action="employee/${msg }.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
		<input type="hidden" name="id" id="id" value="${pd.ID }"/>
		<input type="hidden" name="company" id="company" value="${pd.COMPANY }"/>
		<c:if test="${msg == 'save'}">
			<input type="hidden" name="status" id="status" value="0"/>
			<!-- <input type="hidden" name="reSignUp" id="reSignUp" value="0"/> --><!-- 重复报名更新时间 -->
		</c:if>
		<div style="margin-top: 20px;" id="zhongxin">
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<tr>
		        	<td>
		            	<span style="margin-left:20px;">姓名：</span>
		                <span style="margin-left:10px;"><input id="name" name="name" value="${pd.NAME }" style="width:90px;" type="text"></span>
		           		<span style="margin-left:20px;">性别：</span>
		                <span style="margin-left:10px;">
		                	<select style="width:80px;" id="sex" name="sex" title="性别">
								<option value="0" <c:if test="${pd.SEX == 0 }">selected="selected"</c:if>>男</option>
								<option value="1" <c:if test="${pd.SEX == 1 }">selected="selected"</c:if>>女</option>
							</select>
						</span>
		                <span style="margin-left:30px;">出生年月：</span>
		                <span style="margin-left:10px;">
		                	<input class="input-small input-mask-date" type="text" id="borndate" name="borndate" value="${pd.BORNDATE }" style="width:120px;"/>
		                	<span class="btn btn-small"><i class="icon-calendar"></i></span>
		                </span>
            		</td>
            		<td style="width:124px;" rowspan="4">
            		<div>
            			<div style="width:120px;height:172px;margin: 2px;">
							<c:if test="${pd != null && pd.PHOTO != '' && pd.PHOTO != null }">
								<a href="employee/getPhoto.do?id=${pd.ID}" target="_blank">
								<img id="uploadPreview" style="width: 125px; height: 155px;" src="employee/getPhoto.do?id=${pd.ID}" /></a>
							</c:if>
							<c:if test="${pd == null || pd.PHOTO == '' || pd.PHOTO == null }">
								<img id="uploadPreview" style="width: 120px; height: 160px;" />
							</c:if>
            				<div style="text-align: center;">
            					<a href="javascript:;" class="a-upload" style="margin-top: 3px;">
							    <input id="photo" name="photo" type="file" onchange="loadImageFile();" />点击上传照片
								</a>
            				</div>
         				</div>
            		</div>
            		</td>
        		</tr>
        		<tr>
		        	<td>
		            	<span style="margin-left:20px;">国籍：</span>
		                <span style="margin-left:10px;"><input id="nationality" name="nationality" value="${pd.NATIONALITY }" style="width:60px;" type="text"></span>
		           		<span style="margin-left:20px;">身份证号：</span>
		                <span style="margin-left:10px;"><input id="idcard" name="idcard" value="${pd.IDCARD }" style="width:150px;" type="text"></span>
		                <span style="margin-left:20px;">文化程度：</span>
		                <span style="margin-left:10px;"><input id="educated" name="educated" value="${pd.EDUCATED }" style="width:80px;" type="text">
		                	<%-- <select style="width:120px;" id="educated" name="educated" title="文化程度">
								<option value="0" <c:if test="${pd.EDUCATED == 0 }">selected="selected"</c:if>>初中</option>
								<option value="1" <c:if test="${pd.EDUCATED == 1 }">selected="selected"</c:if>>专科</option>
								<option value="2" <c:if test="${pd.EDUCATED == 2 }">selected="selected"</c:if>>本科</option>
								<option value="3" <c:if test="${pd.EDUCATED == 3 }">selected="selected"</c:if>>研究生</option>
							</select> --%>
		                </span>
            		</td>
        		</tr>
				<tr>
		        	<td>
		            	<span style="margin-left:20px;">联系电话：</span>
		                <span style="margin-left:10px;"><input id="phone" name="phone" value="${pd.PHONE }" style="width:180px;" type="text"></span>
		            	<span style="margin-left:20px;">申报材料页数：</span>
		                <span style="margin-left:10px;"><input id="infoPages" name="infoPages" value="${pd.INFO_PAGES }" style="width:195px;" type="number"></span>
            		</td>
        		</tr>
        		<tr>
		        	<td>
		            	<span style="margin-left:20px;">驾驶证号：</span>
		                <span style="margin-left:10px;"><input id="driveCard" name="driveCard" value="${pd.DRIVE_CARD }" style="width:150px;" type="text"></span>
		           		<span style="margin-left:20px;">驾驶证初领日期：</span>
		                <span style="margin-left:10px;">
		                	<input class="input-small input-mask-date" id="driveStartDate" name="driveStartDate" value="${pd.DRIVE_START_DATE }" style="width:215px;" type="text">
		                </span>
            		</td>
        		</tr>	
        		<tr>
		        	<td colspan="2">
		           		<span style="margin-left:20px;">住址：</span>
		                <span style="margin-left:10px;"><input id="address" name="address" value="${pd.ADDRESS }" style="width:690px;" type="text"></span>
            		</td>
        		</tr>	
        		<tr>
		        	<td colspan="2">
		                 <span style="margin-left:20px;">准驾车型：</span>
		                <span style="margin-left:10px;"><input id="driveType" name="driveType" value="${pd.DRIVE_TYPE }" style="width:145px;" type="text"></span>
		                <span style="margin-left:20px;">原属公司：</span>
		                <span style="margin-left:10px;">
		                	<select class="chzn-select" name="oldCompany" id="oldCompany" data-placeholder="请选择原公司" style="vertical-align:top;width: 170px;">
								<c:if test="${pd.OLD_COMPANY == '无'}"><option value="无">无</option></c:if>
								<option value=""></option>
								<c:if test="${pd.OLD_COMPANY != '无'}"><option value="无">无</option></c:if>
								<c:forEach items="${enterpriseInfo}" var="enterpriseInfo">
									<option value="${enterpriseInfo.UNITNAME }" <c:if test="${enterpriseInfo.UNITNAME == pd.OLD_COMPANY }">selected</c:if>>${enterpriseInfo.UNITNAME }</option>
								</c:forEach>
							</select>
						</span>
            		</td>
        		</tr>
        		<tr>
				<td class="center" colspan="2">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
			</table>
		</div>
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
		
	</form>
	
	
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
			oFReader = new FileReader(), rFilter = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i;
			
			oFReader.onload = function (oFREvent) {
			  document.getElementById("uploadPreview").src = oFREvent.target.result;
			};
			
			function loadImageFile() {
			  if (document.getElementById("photo").files.length === 0) { return; }
			  var oFile = document.getElementById("photo").files[0];
			  if (!rFilter.test(oFile.type)) { alert("上传图片类型不符!"); return; }
			  oFReader.readAsDataURL(oFile);
			}
		</script>

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
		
		</script>
	
</body>
</html>