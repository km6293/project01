<%@page import="myshop.shopuser.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="dto" class = "myshop.shopuser.UserDTO" />
<jsp:setProperty name = "dto" property="*" />
	<%
		request.setCharacterEncoding("UTF-8");
		UserDAO dao = new UserDAO();
		String name = request.getParameter("user_name2");
	 	String phone = request.getParameter("user_phone2");
	 	
	 	String result = dao.searchId(name,phone);
 
		if (result != null) {%>
			<script>
				alert('ID :<%=result%>');
				location.href="/myShop/login/loginForm.jsp";
			</script> 
		 <%} else {%>
			<script>
				alert("회원에 맞는 아이디가없습니다.")
				location.href="/myShop/login/searchId.jsp";
			</script> 
		 <%}
	%>