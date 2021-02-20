<%@page import="myshop.shopuser.UserDAO"%>
<%@page import="myshop.shopuser.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
    <h1>회원가입Pro</h1>

    <jsp:useBean id="dto" class= "myshop.shopuser.UserDTO" />
    <jsp:setProperty property="*" name="dto" />

     	<%
	    	UserDAO dao = new UserDAO();
     		String user_name = dto.getUser_name();
	        boolean result = dao.userselId(dto.getUser_id());
	        if(result){
	    %>
	    <script>
			alert("이 아이디는 있는 아이디거나 삭제된 아이디 입니다.");
			history.back();
		</script>  
	    <%	
	        }else{
	        	dto.setUser_address(request.getParameter("user_address1"));
	        	dto.setUser_address(request.getParameter("user_address2"));
	        	dto.setUser_address(request.getParameter("user_address3"));
	        	dao.insert(dto); 
	    %>
	    <script>
				alert("판매자로 등록되기 까지 최대 2일후 로그인 하실수 있습니다.");
				location.href="/myShop/login/loginForm.jsp";
		</script> 
	    <%
	        }
    	%>
    	
