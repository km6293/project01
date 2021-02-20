<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
		response.setStatus(HttpServletResponse.SC_OK);
	%>
	<!-- 404에러페이지 -->
	<h1>삭제되었거나, 없는 페이지입니다.</h1>
	<button type="button" onclick="location.href='/myShop/index.jsp' ">메인으로 돌아가기/</button>
	
</body>
</html>