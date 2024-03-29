﻿<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Food" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Food food = (Food)request.getAttribute("food");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>查看宠物粮食详情</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li><a href="<%=basePath %>Food/frontlist">宠物粮食信息</a></li>
  		<li class="active">详情查看</li>
	</ul>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">宠粮id:</div>
		<div class="col-md-10 col-xs-6"><%=food.getFoodId()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">宠粮名称:</div>
		<div class="col-md-10 col-xs-6"><%=food.getFoodName()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">宠粮照片:</div>
		<div class="col-md-10 col-xs-6"><img class="img-responsive" src="<%=basePath %><%=food.getFoodPhoto() %>"  border="0px"/></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">宠粮介绍:</div>
		<div class="col-md-10 col-xs-6"><%=food.getFoodDesc()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">库存数量:</div>
		<div class="col-md-10 col-xs-6"><%=food.getFoodNum()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">上架日期:</div>
		<div class="col-md-10 col-xs-6"><%=food.getAddDate()%></div>
	</div>
	
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">预订数量:</div>
		<div class="col-md-10 col-xs-6">
			<input type="text" style="width:100%" id="orderNumber"/>
		</div>
	</div>
	
	
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4"></div>
		<div class="col-md-6 col-xs-6">
			<button onclick="foodOrder();" class="btn btn-primary">我要订购</button>
			<button onclick="history.back();" class="btn btn-info">返回</button>
		</div>
	</div>
</div> 
<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script>
var basePath = "<%=basePath%>";
$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
 });


function foodOrder() {
	var orderNumber = $("#orderNumber").val();
	if(orderNumber == "") {
		alert("请输入订购数量");
		return;
	}
	if (!(/(^[1-9]\d*$)/.test(orderNumber))) {
		alert('输入的不是正整数');
		return; 
	}
	
	$.ajax({
		url : basePath + "FoodOrder/userAdd",
		type : "post",
		data: {
			"foodOrder.foodObj.foodId": <%=food.getFoodId() %>,
			"foodOrder.orderNumber": orderNumber
		},
		success : function (data, response, status) {
			//var obj = jQuery.parseJSON(data);
			if(data.success){
				alert("订单提交成功~");
				location.reload();
			}else{
				alert(data.message);
			}
		}
	});
}



 </script> 
</body>
</html>

