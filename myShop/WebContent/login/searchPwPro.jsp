<%@page import="myshop.shopuser.UserDAO"%>
<%@page import="myshop.shopuser.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="dto" class = "myshop.shopuser.UserDTO" />
<jsp:setProperty name = "dto" property="*" />
	<%
	
		request.setCharacterEncoding("UTF-8");
		UserDAO dao = new UserDAO();
	 
		String id = request.getParameter("user_id2");
		String name = request.getParameter("user_name2");
	 	String phone = request.getParameter("user_phone2");
	 	String result = dao.searchPw(id,name,phone);

		if (result != null) {%>
			<script>
				alert('ID : <%=result%>');
				location.href="/myShop/login/loginForm.jsp";
			</script>
		 <%} else {%>
		<script>
				alert("회원에 맞는 비밀번호가없습니다.")
				location.href="/myShop/login/searchPw.jsp";
		</script> 
	 <%}
	%>
	