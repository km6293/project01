<%@page import="myshop.shopuser.UserDAO"%>
<%@page import="myshop.shopuser.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<link rel="stylesheet" type="text/css" href="/myShop/css/index.css">
<style>
</style>
<div id="footer-box">
<div class="clear"></div>
	<div>
		<h2 id="logo2">myShop</h2>
	<div id="con">	서울시 관악구 남부순환로 1820  <samp style="font-size: 5px;">(에그엘로우)</samp> | TEL : 070-2832-7560 | FAX : 02-231-1223 <br>
		사업자등록번호 : 089-81-045481 | 대표메일 : gmlcjs8@naver.com</div><br>
	<span id="copy1">	&copy; 2020 MY SHOP COMPANY . GIVE ME A CALL</span>
	</div>
<%!
	String sessionId123111 ;
%>
	<% 
	UserDAO userdao123111 = UserDAO.getInstance();
	String sessionId123111 = (String)session.getAttribute("sessionId");
	if(sessionId123111 != null){
	UserDTO user123 = userdao123111.myInfo(sessionId123111); 
	String sessionRating = user123.getRating();%>
	<%if(sessionRating.equals("5")){ %>
	<button onclick="location.href='/myShop/manager/opMain.jsp';" style="width:150px; height:43px; cursor:hand; opacity:0;">
<%}
	}%>
</div>