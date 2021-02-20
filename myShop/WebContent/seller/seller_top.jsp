<%@page import="myshop.shopuser.UserDTO"%>
<%@page import="myshop.shopuser.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/myShop/css/index.css">
<br />
<br />
<br />
<br />
<br />
<%!String sessionId;%>
<div id="mainframe" style="border-color: red;">
	<div id="top">
		<div id="header_brandform"></div>
		<ul>
			<li>&nbsp;</li>
			<li>&nbsp;</li>
		</ul>
		<div id="header_member">
			<%
				if (session.getAttribute("sessionId") != null) {
					sessionId = (String) session.getAttribute("sessionId");
					UserDAO topdao = new UserDAO();
					UserDTO topdto = topdao.myInfo(sessionId);
					String rating = topdto.getRating();
			%>
						<% if(rating.equals("1")){%>
			<script>
			alert("권한이 없습니다");
			location.replace("/myShop/index.jsp");
			</script>
						<%}else if(rating.equals("2")){%>
						<ul>
							<li><%=sessionId%>님</li>
							<li>|</li>
							<li><a href="/myShop/seller/sellerSales.jsp">가게 정보</a></li>
							<li style="font-size: 5;"><a href="/myShop/login/logout.jsp"><img src="/myShop/dev_img/out.png" width="50"></button></a></li>
						</ul>
						<%}else{%>
						<ul>
						<li><%=sessionId%>님</li>
						<li>|</li>
						<li>운영자 또는 미등급</li>
						<li style="font-size: 5;"><a href="/myShop/login/logout.jsp"><img src="/myShop/dev_img/out.png" width="50"></button></a></li>
					</ul>
					<%} %>
			<%
				} else {
			%>
			<ul>
				<li><a href="/myShop/login/intac.jsp">회원가입</a></li>
				<li>|</li>
				<li><a href="/myShop/login/loginForm.jsp">로그인</a></li>
			</ul>
			<%
				}
			%>
		</div>
	</div>

	<div id="mainmenu">
		<div id="logo">
			<a href="/myShop/index.jsp">myShop</a>
		</div>
		<div id="menu">
			<ul>
            <li><a href="/myShop/seller/sellerSales.jsp">매출확인</a></li>
            <li><a href="/myShop/seller/sellerStore.jsp">상품관리</a></li>
            <li><a href="/myShop/contact/contactList.jsp">문의답변</a></li>
         </ul>
      </div>
   </div>
</div>