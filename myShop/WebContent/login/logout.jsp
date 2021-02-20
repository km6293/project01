<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <h1>logout페이지</h1>
    
    <%
		session.invalidate(); 
		Cookie [] acookies = request.getCookies();
		if(acookies != null){
			for(Cookie c : acookies){
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
		response.sendRedirect("/myShop/index.jsp?logout=true");
    %>