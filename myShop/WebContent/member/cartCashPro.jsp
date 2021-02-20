<%@page import="myshop.shopuser.UserDAO"%>
<%@page import="myshop.shopuser.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="dto" class="myshop.shopuser.UserDTO" />
<jsp:setProperty name="dto" property="*" />
<% 
	request.setCharacterEncoding("UTF-8");

	String sessionId = (String) session.getAttribute("sessionId");
	if (sessionId == null) {
		response.sendRedirect("/myShop/login/loginForm.jsp");
	}else{
	UserDAO dao = new UserDAO();
	dao.myInfo(sessionId);

	String parcash = request.getParameter("user_cash1");
	String dtocash = dto.getUser_cash();
	int a = Integer.parseInt(parcash);
	int b = Integer.parseInt(dtocash);
	int c = a + b;
	String cash = Integer.toString(c);
	dto.setUser_cash(cash);
	dao.cashUpdate(dto);
%>
<script>
	alert("충전되었습니다.");
	history.go(-3);
</script>
<%	}%>