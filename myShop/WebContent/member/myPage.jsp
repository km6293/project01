<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 
    <%! String id,pw,auto; %>
    <%

    	if(session.getAttribute("sessionId") == null){
    		Cookie [] cookies = request.getCookies();
    		if(cookies != null){
    			for(Cookie c : cookies){
    				if(c.getName().equals("cid")) id = c.getValue();
    				if(c.getName().equals("cpw")) pw = c.getValue();
    				if(c.getName().equals("cauto")) auto = c.getValue();				
    			}
    		}
    		if(auto != null && id != null && pw != null){
    			response.sendRedirect("/myShop/login/cookiePro.jsp");
    		}else{
    			response.sendRedirect("/myShop/login/loginForm.jsp");
    		}
    	}else{
%>
<body style="text-align: center;">
    	<%@ include file="/include/top.jsp"%> <!-- 상단 -->
	<div>
		<br />
		
			<h1> 나의 정보 </h1>
			<br/>
			<div>
				<button onclick="window.location='/myShop/login/myInfo.jsp'" style="width: 90px;" >내 정보 확인</button><br /><br />
			</div>
			<div>
				<button onclick="window.location='/myShop/login/deleteForm.jsp'" style="width: 90px;">탈퇴</button><br /><br />
			</div>
			<div>
				<button onclick="window.location='/myShop/login/logout.jsp'" style="width: 90px;">로그아웃</button><br /><br />
			</div>
			<div>
				<button onclick="window.location='/myShop/member/cash.jsp'" style="width: 90px;">충전</button><br /><br />
			</div>
			<div>
				<button onclick="window.location='/myShop/member/myCommuList.jsp'" style="width: 90px;">내가 쓴 글</button><br /><br />
			</div>
			<div>
				<button onclick="window.location='/myShop/member/cartList.jsp'" style="width: 90px;">장바구니</button><br /><br />
			</div>
			<div>
				<button onclick="window.location='/myShop/member/myOrder.jsp'" style="width: 90px;">구매 내역</button><br /><br />
			</div>
			<div>
				<button onclick="window.location='/myShop/contact/contactList.jsp'" style="width: 90px;">내문의내역</button><br /><br />
			</div>
			
	</div>
<%}%>