<%@page import="myshop.shopuser.UserDTO"%>
<%@page import="myshop.shopuser.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
		String sessionId = (String)session.getAttribute("sessionId");
		if(sessionId == null){
			response.sendRedirect("/shopTest/login/loginForm.jsp");
		}
		UserDAO dao = new UserDAO();
		UserDTO dto = dao.myInfo(sessionId);
    %>
    
        현재잔액 : <%=dto.getUser_cash() %> <br />
	
	<form action="cartCashPro.jsp" method="post">
	<input type = "hidden" name="user_id" value ="<%= dto.getUser_id() %>" /> <br />
	<input type = "hidden" name ="user_cash" value ="<%=dto.getUser_cash()%>" /> <br />
	<input type="number"  name ="user_cash1" placeholder="충전금액">
    <input type="submit" value="충전">
	</form >
	
	
	<button onclick="window.location='/myShop/member/myPage.jsp'" style="width: 90px;">메인</button>