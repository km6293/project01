<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="myshop.cart.CartDAO" %>
<%@page import="myshop.cart.CartDTO" %>
<%@page import="myshop.goods.MyShopDAO" %>   
<%@page import="myshop.shoporder.OrderDAO" %>  
<%@page import="java.util.List" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>

<%@ include file="/include/top.jsp"%>
<br />
<%
     String sessionId = (String)session.getAttribute("sessionId");
    if(sessionId==null)
  	{
%>
	<script>
      alert("로그인 후 이용 가능합니다");
      window.location='/myShop/login/loginForm.jsp';
     </script>

<%} %>
<%
	int pageSize=10;
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }
    
    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0; //담긴 상품 개수
    int goods_code=0; 
	int number=0;
	int cartTotalPrice = 0; //장바구니 총액
	int selected = 1;
	List cartList = null;
    CartDAO c_dao = CartDAO.getInstance();
    MyShopDAO dao = MyShopDAO.getInstance();
	count = c_dao.getCartCount(sessionId);
	DecimalFormat df = new DecimalFormat("###,###");
	if (count > 0){
		cartList = c_dao.getCartList(sessionId, startRow, endRow);
	}
%>
	
<html>
<head>
<title>장바구니</title>
</head>

<body bgcolor="white">
<center><b>[<%=sessionId%>]님의 장바구니</b>

<table width="600" border=1 cellpadding="0" ceppspacing="0" align=center>
<%
	if(count == 0){ 
%>
<tr>
	<td align="center">
	장바구니에 저장된 상품이 없습니다.
	</td>
</tr>
<tr>
	<td align="center"><input type="button" value="담으러 가기" onclick="document.location.href='/myShop/board/goodsList.jsp'"></td>
</tr>
</table>
<%	}else{
%>
	
<form method="post" name="cartList" action="/myShop/board/cartBuyForm.jsp">
	<tr>
	  <td align="center" width="50">선택</td>
      <td align="center" width="250">상품</td>
      <td align="center" width="100">수량</td>
      <td align="center" width="100">금액</td>
      <td align="center" width="100">삭제</td>
	</tr>
	<%
		for (int i = 0; i < cartList.size(); i++) {
			CartDTO cart = (CartDTO)cartList.get(i);
	%>
	<tr height="30">
		<input type="hidden" name="user_id" value="<%=sessionId %>">
		<input type="hidden" name="goods_code" value="<%=goods_code %>">
		<td align="center"><input type="checkbox" name="cartCheck" value="<%=selected++%>" checked></td>
		<td align="center" width="250" ><a href="/myShop/board/goodsDetail.jsp?goods_code=<%=cart.getGoods_code()%>"><%=cart.getGoods_name() %></a></td>
		<td align="center" width="100"><%=cart.getAmount()%></td>
		<td align="center" width="100" ><%=df.format(cart.getGoods_price())%>원</td>
		<td align="center"><input type="button" value="삭제" onclick="document.location.href='cartDel.jsp?user_id=<%=sessionId%>&goods_code=<%=cart.getGoods_code()%>&pageNum=<%=pageNum%>'"></td>
		 <% cartTotalPrice += (cart.getAmount() * cart.getGoods_price()); %>
 	 </tr>
     <%}%>
      <tr>
 	 	<td align="right" colspan="5"> 총 금액:<%=df.format(cartTotalPrice)%> 원<br/>
 	 	<input type="button" value="담으러 가기" onclick="document.location.href='/myShop/board/goodsList.jsp'">
 	 	<input type="submit" value="선택상품 주문"></td><br />
 	 </tr>
</table>
	
<%}%>

</center>
</body>
</html>
<br /><br /><br /><br /><br />
<%@ include file="/include/bottom.jsp" %> <!--하단 -->

	