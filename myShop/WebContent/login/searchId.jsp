<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
  	<%@ include file="/include/top.jsp"%> <!-- 상단 -->
<% request.setCharacterEncoding("UTF-8"); %>

<body style="text-align: center;">
	<div>
		<br />
		<form action="searchIdPro.jsp" method="get">
			<h1> 아이디 찾기</h1>
			<br/>
			<div>
				이름  <input type="text" placeholder="이름" name="user_name2" maxlength="20" style="height: 30px; margin-bottom: 10px;">
			</div>
			<div>
				번호  <input type="text" placeholder="'-'없이 입력해주십시오" name="user_phone2" maxlength="20" style="height: 30px; margin-bottom: 10px;">
			</div>
			<input type="submit" value="아이디 찾기" style="width: 180px; height: 40px;margin-bottom: 10px;">
		</form>
	</div>
	
   
   <button onclick="window.location='/myShop/login/loginForm.jsp'" style="width: 90px;">로그인</button>
   <button onclick="window.location='/myShop/login/searchPw.jsp'"style="width: 90px;">비번찾기</button>