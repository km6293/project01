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
<% String rating1=""; %>
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
					rating1=rating;
			%>
						<% if(rating.equals("1")){%>
			<ul>
				<li><%=sessionId%>님</li>
				<li>|</li>
				<li><a href="/myShop/member/myPage.jsp">내 정보</a></li>
				<li style="font-size: 5;"><a href="/myShop/login/logout.jsp"><img src="/myShop/dev_img/out.png" width="50"></button></a></li>
			</ul>
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
						<li>운영자 <li style="font-size: 5;"><a href="/myShop/login/logout.jsp"><button style="border: 0px;"  type="button"><img src="/myShop/dev_img/out.png" width="50"></button></a></li>
						</li>
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
			<%
			if(rating1.equals("2")){
				%>
				<li>
				<a  href="void(0);" onclick="alert('판매자는 권한없음');return false;">스토어</a>
				</li>
				<%}else{ %>
				<li><a href="/myShop/board/goodsList.jsp">스토어</a></li>
				<%} %>
				<li><a href="/myShop/community/commuList.jsp">커뮤니티</a></li>
				<li><a href="/myShop/community/opBoard.jsp">문의하기</a></li>
			</ul>
		</div>
	</div>
</div>
<br/><br/><br/>
