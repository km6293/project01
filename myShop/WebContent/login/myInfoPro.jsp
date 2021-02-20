<%@page import="myshop.shopuser.UserDAO"%>
<%@page import="myshop.shopuser.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <h1>정보수정Pro</h1>
    
    <%
		request.setCharacterEncoding("UTF-8");
                    
		String sessionId = (String)session.getAttribute("sessionId");
		if(sessionId == null){
			response.sendRedirect("/myShop/login/loginForm.jsp");
		} 
    %>
	<jsp:useBean id="dto" class = "myshop.shopuser.UserDTO" />
	<jsp:setProperty name = "dto" property="*" />
	
	<%
			UserDAO dao = new UserDAO();
			dao.update(dto);
	%>
	<script>
		alert("수정되었습니다.");
		window.location="/myShop/member/myPage.jsp";
	</script>