<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String username = (String) session.getAttribute("user_name");
	if (username == null) {
		response.getWriter()
				.println("<script>alert('请先登录');top.location.href='" + basePath + "index.jsp';</script>");
	}
%>