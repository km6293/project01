<%@page import="myshop.shopuser.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <h1>회원탈퇴Pro</h1>
            
    <jsp:useBean id="dto" class="myshop.shopuser.UserDTO" />
    <jsp:setProperty property="*" name="dto" />
        	 
    <%
        	String user_id = request.getParameter("sessionId");
            String join = request.getParameter("join");
        	UserDAO dao = new UserDAO();
        	dao.userDelete(user_id);
        	session.invalidate(); 
    		String id = null, pw = null, auto = null;
    		Cookie [] cookies = request.getCookies();
    		if(cookies != null){
    			for(Cookie c : cookies){
    				if(c.getName().equals("cid")){
    					c.setMaxAge(0);
    					response.addCookie(c);
    				}
    				if(c.getName().equals("cpw")){
    					c.setMaxAge(0);
    					response.addCookie(c);
    				}
    				if(c.getName().equals("cauto")){
    					c.setMaxAge(0);
    					response.addCookie(c);			
    				}
    			}
    		}
    %>

<script>
	alert("삭제되었습니다.");
	window.location="/myShop/login/loginForm.jsp";
</script>