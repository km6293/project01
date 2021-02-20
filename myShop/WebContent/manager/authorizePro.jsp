<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="myshop.shopuser.UserDAO" %>
<%
request.setCharacterEncoding("UTF-8");
String user_id = request.getParameter("user_id");
String currentPage = request.getParameter("currentPage");
UserDAO udao = UserDAO.getInstance();
udao.authorizeSeller(user_id);
%>
<script>
alert("승인되었습니다.");
location.href = "/myShop/manager/authorizeSeller.jsp?pageNum=<%=currentPage%>";
</script>