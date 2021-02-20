<%@page import="myshop.opboard.OpBoardDAO"%>
<%@page import="myshop.opboard.OpBoardDTO"%>

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
    request.setCharacterEncoding("UTF-8");
%>
    <jsp:useBean id="dto" class= "myshop.opboard.OpBoardDTO" />
    <jsp:setProperty property="*" name="dto" />
    
    <% OpBoardDAO dao = OpBoardDAO.getInstance(); 
    dao.insertOpBoard(dto);
    %>
    <script>
				alert("문의가 완료되었습니다.");
				location.href = "/myShop/index.jsp";
			</script>
</body>
</html>