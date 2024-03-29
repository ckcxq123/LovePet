﻿$(function () {
	$.ajax({
		url : "FoodOrder/" + $("#foodOrder_orderId_edit").val() + "/update",
		type : "get",
		data : {
			//orderId : $("#foodOrder_orderId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (foodOrder, response, status) {
			$.messager.progress("close");
			if (foodOrder) { 
				$("#foodOrder_orderId_edit").val(foodOrder.orderId);
				$("#foodOrder_orderId_edit").validatebox({
					required : true,
					missingMessage : "请输入订单id",
					editable: false
				});
				$("#foodOrder_foodObj_foodId_edit").combobox({
					url:"Food/listAll",
					valueField:"foodId",
					textField:"foodName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#foodOrder_foodObj_foodId_edit").combobox("select", foodOrder.foodObjPri);
						//var data = $("#foodOrder_foodObj_foodId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#foodOrder_foodObj_foodId_edit").combobox("select", data[0].foodId);
						//}
					}
				});
				$("#foodOrder_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#foodOrder_userObj_user_name_edit").combobox("select", foodOrder.userObjPri);
						//var data = $("#foodOrder_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#foodOrder_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#foodOrder_orderNumber_edit").val(foodOrder.orderNumber);
				$("#foodOrder_orderNumber_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入预订数量",
					invalidMessage : "预订数量输入不对",
				});
				$("#foodOrder_orderState_edit").val(foodOrder.orderState);
				$("#foodOrder_orderState_edit").validatebox({
					required : true,
					missingMessage : "请输入订单状态",
				});
				$("#foodOrder_orderTime_edit").datetimebox({
					value: foodOrder.orderTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#foodOrderModifyButton").click(function(){ 
		if ($("#foodOrderEditForm").form("validate")) {
			$("#foodOrderEditForm").form({
			    url:"FoodOrder/" +  $("#foodOrder_orderId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#foodOrderEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "正在提交数据中...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#foodOrderEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
