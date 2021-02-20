<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    <%  
    String sessionId = (String)session.getAttribute("sessionId");
		if(sessionId == null){
			response.sendRedirect("/myShop/login/loginForm.jsp");
		}
	%>

   
	<%@ include file="/include/top.jsp"%> <!-- 상단 -->
<body style="text-align: center;">
	<div>
		<br />
		<form action="deletePro.jsp" method="post">
			<h1> 회원탈퇴</h1>
			<br/>
			<div>
				<form action="deletePro.jsp" method="post">
		    		 <input type="hidden" name="user_id" value="<%=sessionId %>" />
		    	pw : <input type="text" name="user_pw" /> <br />
			</div>
			<input type="submit" value="탈퇴" style="width: 180px; height: 40px;margin-bottom: 10px;">
		</form>
	</div>
	
    
   <button onclick="window.location='/myShop/member/myPage.jsp'" style="width: 90px;">메인</button>