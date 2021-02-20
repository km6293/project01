<%@page import="myshop.shoporder.OrderDTO"%>
<%@page import="myshop.shoporder.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="myshop.goods.GoodsDAO"%>
<%@ page import="myshop.goods.GoodsDTO"%>

<%
	//날짜 포맷
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	//세션 획득
    String user_id = (String)session.getAttribute("sessionId");
    //로그인되어 있지 않으면 loginForm.jsp파일로 리디렉트합니다.
    if(user_id==null)
  	{
		response.sendRedirect("loginForm.jsp");
	}
    //거래DB 접근 클래스
    OrderDAO odao = OrderDAO.getInstance();
  	
    //상품DB 접근 클래스
    GoodsDAO gdao = GoodsDAO.getInstance();
    
	int order_number = Integer.parseInt(request.getParameter("order_number"));
	boolean security = odao.contactCheck(order_number, user_id);
	//열람하려는 주문상세페이지의 주문번호와 ID가 대응하지 않으면 경고창을 통해 index.jsp로 리디렉트합니다.
	if(security == false){
%>
<script>
	alert("잘못된 접근입니다.");
	window.location="index.jsp";
</script>
<%	
	}
	
    //CJ대한통운주소
    String cjtrack = "https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=";
  
    //주문가져오기
  	ArrayList listInOrder = new ArrayList();
  	listInOrder = odao.getOrderDetail(order_number,user_id);
    
    //goods_code 보관 변수
    int goods_code = 0;
%>
<html>
<body>
<%@ include file="/include/top.jsp" %>
<center>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
	 <td colspan="9" align="center">
	  <br>
	      <h3>주문번호: <%=order_number%></h3><br>
	      <h3>주문날짜: <%=sdf.format(odao.getOrder_date(order_number))%></h3>
	  <br>
	 </td>
	<tr height="30" bgcolor="white">
		<td align="center" width="50">상품번호</td>
	    <td align="center" width="100">상품이미지</td>
		<td align="center" width="250">상품</td>
		<td align="center" width="50">수량</td>
		<td align="center" width="100">금액</td>
		<td align="center" width="100">판매자</td>
		<td align="center" width="100">운송장번호</td>
	</tr>
<%  
		for (int i = 0 ; i < listInOrder.size() ; i++) 
		{
			//OrderDTO의 객체를 생성한 뒤 listInOrder에서 i번 째 데이터를  꺼내 보관합니다.
			OrderDTO odto = new OrderDTO();
			odto = (OrderDTO)listInOrder.get(i);
        	//GoodsDTO객체를 생성합니다.
        	GoodsDTO gdto = new GoodsDTO();
        	//orderList의 i번 째 데이터에서 외래키인 goods_code를 꺼냅니다.
        	goods_code = odto.getGoods_code();
        	//goods_code를 이용해서 해당 상품의 정보를 객체 gdto에 보관합니다.
        	gdto = gdao.goodsDetail(goods_code);
%>
	<tr height="30">
		<td align="center" width="50">
		<%if(gdto!=null) {%>
	  	 <%=gdto.getGoods_code()%>
	  	 <%} %>
	  	</td>
	  	<td width="120">
	  	<%if(gdto!=null) {%>
	  	 <img src="/myShop/imgsave/sellerimg/<%=gdto.getGoods_img()%>"/>
	  	<%}else{%>
	  	없음
	  	<%} %>
	 	</td>
		<td width="250">
		 <!-- 누르면 새창에서 제품상세페이지 열기  -->
		 <%if(gdto!=null){ %>
		 <a href="/myShop/board/goodsDetail.jsp?goods_code=<%=gdto.getGoods_code()%>">
		 	<%=gdto.getGoods_name() %>
		 </a> 
		 <%}else{%>
		 	존재하지 않는 상품
		 <%} %>
		</td>
		<td align="center" width="50">
		 <%= odto.getAmount()%>
		</td>
		<td align="center" width="50">
		 <%= odto.getTotal_price()%>
		</td>
		<td align="center" width="100">
		 <ul> 
		  <li>
		  <%if(gdto!=null) {%>
		   <%=gdto.getGoods_brand() %>
		   <%}%>
		  </li> 
		  <li>
		   <form action="/myShop/contact/contactForm.jsp" method="post">
    		 <input type="hidden" name="order_number" value="<%=odto.getOrder_number() %>" />
    		 <%if(gdto!=null) {%>
    		 <input type="hidden" name="goods_code" value="<%=gdto.getGoods_code()%>" />
    		 <%} %>
    		 <input type="submit" value="판매자문의"/>
    		</form>
		  </li>
		</td>
		<td align="center" width="120">
		<%if(odto.getTrack()!=null){%>
		 <a href="<%=cjtrack %><%=odto.getTrack() %>">
		  <%=odto.getTrack() %>
		  <%} %>
		 </a>
		</td>
	   </tr>
<%
		}
%>
</table>
<!-- order_number를 파라미터로 갖고 관리자문의 페이지로 이동 -->
<h2>
 <form action="/myShop/community/opBoard.jsp" method="post">
  <input type="hidden" name="order_number" value="<%=order_number%>" />
  <input type="hidden" name="user_id" value="<%=user_id%>"/>
  <input type="submit" value="관리자문의"/>
 </form>
</h2>

</body>
</html>