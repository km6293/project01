<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="myshop.shopuser.UserDAO"%>
<%@page import="myshop.shopuser.UserDTO"%>
<%@page import="myshop.goods.GoodsDAO"%>
<%@page import="myshop.goods.GoodsDTO"%>
<%@page import="myshop.goods.MyShopDAO"%>
<%@page import="myshop.cart.CartDAO"%>
<%@page import="myshop.cart.CartDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>

<html>
<head>
<title>구매정보 입력</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String sessionId = (String) session.getAttribute("sessionId");
%>

<jsp:useBean id="goods" class="myshop.goods.GoodsDTO" />
<jsp:setProperty name="goods" property="*" />

<%
	String amount = request.getParameter("amount");

	if (sessionId == null) {
%>
<script>
	alert("로그인 후 이용 가능합니다");
	window.location = '/myShop/login/loginForm.jsp';
</script>

<%
	} else {
%>
<%
	int count = 0;
		int number = 0;
		int total_price = 0;
		int startRow = 0;
		int endRow = 5;

		List cartList = null;
		CartDTO dto = new CartDTO();
		CartDAO c_dao = CartDAO.getInstance();
		DecimalFormat df = new DecimalFormat("###,###");
		MyShopDAO dao = MyShopDAO.getInstance();
		count = c_dao.getCartCount(sessionId);

		if (count > 0) {
			cartList = c_dao.getCartList(sessionId, startRow, endRow);
		}

		UserDTO userdto = new UserDTO();
		UserDAO userdao = new UserDAO();
		userdto = userdao.myInfo(sessionId);
		int cash = Integer.parseInt(userdto.getUser_cash());
%>


<center>
	<h3>
		<b>구매목록</b>
	</h3>
</center>
<script language="javascript">
	function formCheck(frm) {
		if (frm.re_phone.value == "") {
			alert("받으시는 분의 전화번호를 입력해 주세요!");
			frm.re_phone.focus();
			return false;
		}
		if (frm.re_address.value == "") {
			alert("받으시는 분의 주소를 입력해 주세요!!");
			frm.re_address.focus();
			return false;
		}
	}
</script>

<form method="post" name="buy" action="buyPro.jsp" onsubmit="return formCheck(this)">
	<table width="600" border=1 cellpadding="0" ceppspacing="0"
		align=center>
		<tr>
			<td align="center" width="50">번호</td>
			<td align="center" width="250">상품</td>
			<td align="center" width="100">수량</td>
			<td align="center" width="100">금액</td>
		</tr>
		<tr height="30">
			<td align="center"><%=++number%></td>
			<td align="center" width="250"><%=goods.getGoods_name()%></td>
			<input type="hidden" name="goods_code" value=<%=goods.getGoods_code()%>>
			<td align="center" width="100"><%=amount%></td>
			<input type="hidden" name="amount" value=<%=amount%>>
			<td align="center" width="100"><%=df.format(goods.getGoods_price())%></td>
			<%
				total_price += (Integer.parseInt(amount) * goods.getGoods_price());
			%>
		
		<tr>
			<td align="right" colspan="5"> 배송비: <%=df.format(goods.getGoods_delivery())%> 원 <br />총 금액: <%=df.format(total_price)%>
				원<br />
		</tr>
	</table>

	<br>

	<table width="600" border="1" cellspacing="0" cellpadding="3"
		align="center">
		<tr>
			<td colspan="2" align="center"><h1>01.주문자 정보</h1></td>
		</tr>
		<tr>
			<td width="200">성명</td>
			<td width="400"><%=userdto.getUser_name()%></td>
		</tr>
		<tr>
			<td width="200">전화번호</td>
			<td width="400"><%=userdto.getUser_phone()%></td>
		</tr>
		<tr>
			<td width="200">주소</td>
			<td width="400"><%=userdto.getUser_address()%></td>
		</tr>
	</table>
	<br />


	<table width="600" border="1" cellspacing="0" cellpadding="3"
		align="center">
		<tr>
			<td colspan="2" align="center"><h1>02.배송지 정보</h1></td>
		</tr>
		<tr>
			<td width="200">성명</td>
			<td width="400"><input type="text" name="re_name"
				value="<%=userdto.getUser_name()%>" style="width: 400px;"></td>
		</tr>
		<tr>
			<td width="200">전화번호</td>
			<td width="400"><input type="text" name="re_phone"
				value="<%=userdto.getUser_phone()%>" style="width: 400px;"></td>
		</tr>
		<tr>
			<td width="200">주소</td>
			<td width="400"><input type="text" name="re_address"
				value="<%=userdto.getUser_address()%>" style="width: 400px;"></td>
		</tr>
	</table>
	<br />
	<table width="600" border="1" cellspacing="0" cellpadding="3"
		align="center">
		<tr>
			<td colspan="2" align="center"><h1>03.결제 정보</h1></td>
		</tr>
		<tr>
			<td width="200">보유 캐시</td>
			<td width="400"><%=df.format(cash)%></td>
		</tr>
		<tr>
			<td width="200">결제 금액</td>
			<%int price = goods.getGoods_delivery()+total_price; %>
			<td width="400"><%=df.format(price)%></td>
		</tr>
		<tr>
			<td width="200">남는 캐시</td>
			<%
				int remain = cash - price;
					if (remain > 0) {
			%>
			<td width="400"><%=df.format(remain)%></td>
			<%
				} else {
			%>
			<td width="400">보유 캐시가 부족합니다.</td>
			<%
				}
			%>
		</tr>
		<tr>
			<td colspan="2" align="center"><input type="hidden"
				name="total_price" value=<%=total_price%>> <input
				type="hidden" name="remain" value=<%=remain%>> <input
				type="hidden" name="goods_brand" value=<%=goods.getGoods_brand()%>> <%
 	if (remain > 0) {
 %>
				<input type="submit" value="결제"> <%
 	} else {
 %> <input
				type="button" value="충전하기"
				onclick="location.href='/myShop/member/cartCash.jsp'"> <%
 	}
 %>
				<input type="button" value="취소"
				onclick="location.href='/myShop/board/goodsList.jsp'"></td>
		</tr>
	</table>
</form>
</body>
</html>
<%
	}
%>

