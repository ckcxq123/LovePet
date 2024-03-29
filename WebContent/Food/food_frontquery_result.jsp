﻿<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Food" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Food> foodList = (List<Food>)request.getAttribute("foodList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String foodName = (String)request.getAttribute("foodName"); //宠粮名称查询关键字
    String addDate = (String)request.getAttribute("addDate"); //上架日期查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>宠物粮食查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Food/frontlist">宠物粮食信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Food/food_frontAdd.jsp" style="display:none;">添加宠物粮食</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<foodList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Food food = foodList.get(i); //获取到宠物粮食对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Food/<%=food.getFoodId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=food.getFoodPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		宠粮id:<%=food.getFoodId() %>
			     	</div>
			     	<div class="field">
	            		宠粮名称:<%=food.getFoodName() %>
			     	</div>
			     	<div class="field">
	            		库存数量:<%=food.getFoodNum() %>
			     	</div>
			     	<div class="field">
	            		上架日期:<%=food.getAddDate() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Food/<%=food.getFoodId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="foodEdit('<%=food.getFoodId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="foodDelete('<%=food.getFoodId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>宠物粮食查询</h1>
		</div>
		<form name="foodQueryForm" id="foodQueryForm" action="<%=basePath %>Food/frontlist" class="mar_t15">
			<div class="form-group">
				<label for="foodName">宠粮名称:</label>
				<input type="text" id="foodName" name="foodName" value="<%=foodName %>" class="form-control" placeholder="请输入宠粮名称">
			</div>
			<div class="form-group">
				<label for="addDate">上架日期:</label>
				<input type="text" id="addDate" name="addDate" class="form-control"  placeholder="请选择上架日期" value="<%=addDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="foodEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;宠物粮食信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="foodEditForm" id="foodEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="food_foodId_edit" class="col-md-3 text-right">宠粮id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="food_foodId_edit" name="food.foodId" class="form-control" placeholder="请输入宠粮id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="food_foodName_edit" class="col-md-3 text-right">宠粮名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="food_foodName_edit" name="food.foodName" class="form-control" placeholder="请输入宠粮名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="food_foodPhoto_edit" class="col-md-3 text-right">宠粮照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="food_foodPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="food_foodPhoto" name="food.foodPhoto"/>
			    <input id="foodPhotoFile" name="foodPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="food_foodDesc_edit" class="col-md-3 text-right">宠粮介绍:</label>
		  	 <div class="col-md-9">
			 	<textarea name="food.foodDesc" id="food_foodDesc_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="food_foodNum_edit" class="col-md-3 text-right">库存数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="food_foodNum_edit" name="food.foodNum" class="form-control" placeholder="请输入库存数量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="food_addDate_edit" class="col-md-3 text-right">上架日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date food_addDate_edit col-md-12" data-link-field="food_addDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="food_addDate_edit" name="food.addDate" size="16" type="text" value="" placeholder="请选择上架日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#foodEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxFoodModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var food_foodDesc_edit = UE.getEditor('food_foodDesc_edit'); //宠粮介绍编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.foodQueryForm.currentPage.value = currentPage;
    document.foodQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.foodQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.foodQueryForm.currentPage.value = pageValue;
    documentfoodQueryForm.submit();
}

/*弹出修改宠物粮食界面并初始化数据*/
function foodEdit(foodId) {
	$.ajax({
		url :  basePath + "Food/" + foodId + "/update",
		type : "get",
		dataType: "json",
		success : function (food, response, status) {
			if (food) {
				$("#food_foodId_edit").val(food.foodId);
				$("#food_foodName_edit").val(food.foodName);
				$("#food_foodPhoto").val(food.foodPhoto);
				$("#food_foodPhotoImg").attr("src", basePath +　food.foodPhoto);
				food_foodDesc_edit.setContent(food.foodDesc, false);
				$("#food_foodNum_edit").val(food.foodNum);
				$("#food_addDate_edit").val(food.addDate);
				$('#foodEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除宠物粮食信息*/
function foodDelete(foodId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Food/deletes",
			data : {
				foodIds : foodId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#foodQueryForm").submit();
					//location.href= basePath + "Food/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交宠物粮食信息表单给服务器端修改*/
function ajaxFoodModify() {
	$.ajax({
		url :  basePath + "Food/" + $("#food_foodId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#foodEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#foodQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

    /*上架日期组件*/
    $('.food_addDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

