<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
	String sessionId = (String)session.getAttribute("sessionId");
	if(sessionId != null){
		response.sendRedirect("/myShop/index.jsp");
	}
	%>
<body style="text-align: center;">
	<%@ include file="/include/top.jsp"%> <!-- 상단 -->
	<div>
		<br/> 
		<form action="cookiePro.jsp" method="post">
			<h1>로그인화면</h1>
			<br/>
			<div>
				<input type="text" placeholder="아이디" name="user_id" maxlength="20" style="height: 30px; margin-bottom: 10px;">
			</div>
			<div>
				<input type="password" placeholder="비밀번호" name="user_pw" maxlength="20" style="height: 30px; margin-bottom: 10px;">
			</div>
			<div style="text-align: center;">
				<div data-toggle="buttons">
					 <label><input type="checkbox" name="auto" value="1" style="margin-bottom: 10px;"/> 자동로그인 <br/></label>
				</div>
			</div>
			<input type="submit" value="로그인하기" style="width: 180px; height: 40px;margin-bottom: 10px;">
		</form>
	</div>
	
    
   <button onclick="window.location='/myShop/login/searchId.jsp'"style="width: 90px;">아이디찾기</button>
   <button onclick="window.location='/myShop/login/searchId.jsp'"style="width: 90px;">비번찾기</button>
