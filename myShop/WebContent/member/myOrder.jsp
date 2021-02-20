<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="myshop.goods.GoodsDTO"%>
<%@page import="myshop.shoporder.OrderDTO"%>
<%@page import="myshop.shoporder.OrderDAO"%>
<%@page import="myshop.goods.GoodsDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page import="java.text.DecimalFormat" %>
<%	DecimalFormat df = new DecimalFormat("###,###");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	//세션 획득
	String user_id = (String) session.getAttribute("sessionId");
	//로그인되어 있지 않으면 loginForm.jsp파일로 리디렉트합니다.
	if (user_id == null) {
		response.sendRedirect("loginForm.jsp"); 
	}
	//현재 페이지 확인
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum = "1";
	}
	//목록

	int pageSize = 10; //페이지 크기
	int currentPage = Integer.parseInt(pageNum); //현재페이지
	int startRow = (currentPage - 1) * pageSize + 1; //첫번째열
	int endRow = currentPage * pageSize; //마지막열
	int count = 0; //주문 수
	int goods_code = 0; //상품번호

	//preMonths-nextMonths = 검색기간(단위:월)
	//예시:
	//preMonths=11, nextMonths=2 일 때
	//sysdate를 기준 11개월 전 부터 2개월 전까지 총 9개월 간의 주문을 검색
	int preMonths = 12;//= sysdate-fisrtdate
	int nextMonths = 0;//= sysdate-lastdate

	//거래DB 접근 클래스
	OrderDAO odao = OrderDAO.getInstance();

	//상품DB 접근 클래스
	GoodsDAO gdao = GoodsDAO.getInstance();

	//주문개수 세기
	count = odao.getOrderCount(user_id);
%>
<html><head><title>구매 내역</title><meta charset="UTF-8"></head>
<body>
<%@ include file="/include/top.jsp" %>
 <center>
   <h2>구매 내역</h2>
<%
   	if (count == 0) {
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
    <td align="center">
    	내역이 없습니다.
    </td>
</table>
<%
	} else {
%>
		<table border="1" align="center">
		  <tr height="30" bgcolor="white">
		   <td align="center" width="100">주문번호</td>
		   <td align="center" width="100">상품이미지</td>
		   <td align="center" width="250">상품이름</td>
		   <td align="center" width="100">금액</td>
		   <td align="center" width="100">주문일자</td>
		   <td align="center" width="100"></td>
		  </tr>
<%
	 List<OrderDTO> orderList = odao.getOrderList(user_id, preMonths, nextMonths, startRow, endRow);

	if(orderList!=null){
     for (int i = 0; i < orderList.size(); i++) {
	  //OrderDTO의 객체를 생성한 뒤 orderList에서 i번 째 데이터를  꺼내 보관합니다.
	  OrderDTO odto = (OrderDTO) orderList.get(i);

	  //GoodsDTO객체를 생성합니다.
	  GoodsDTO gdto = new GoodsDTO();
	  //orderList의 i번 째 데이터에서 외래키인 goods_code를 꺼냅니다.
	  goods_code = odto.getGoods_code();
	  //goods_code를 이용해서 해당 상품의 정보를 객체 gdto에 보관합니다.
	  gdto = (GoodsDTO) gdao.goodsDetail(goods_code);
	  //상품개수
	  int countGoods = odao.getCountGoodsInOrder(odto.getOrder_number(),user_id) - 1;
%>
	  <tr height="30">
	   <td align="center" width="100"><%=odto.getOrder_number()%></td>
	   <td align="center" width="150">
<%
		if (gdto != null) {
			if(gdto.getGoods_img() != null){
%> 
		 		<img src="/myShop/imgsave/sellerimg/<%=gdto.getGoods_img()%>" /> 
<%
 			}else{
%>
			이미지없음
<%			}
		}
%>
		</td>
		<td width="250">
<!-- OrderDAO의 getCountGoodsInOrder()메소드는 같은 주문 안에 몇 종류의 상품이 있는 지 세어서 그 수를 int로 돌려줍니다. -->
		 <%if(gdto != null){%>
		 	<%=gdto.getGoods_name()%>
		 <%}else{%>
		 존재하지 않는 상품
		 <%} %>
<%
 		 if (countGoods > 0) {
%> 
		  외 <%=countGoods%>개 상품 
<%
 		 }
%>
		 </td>
		 <td align="center" width="50">
		  <%=df.format(odao.getTotal_priceInOrder(odto.getOrder_number(),user_id))%>원
		 </td>
		 <td align="center" width="100">
		  <%=sdf.format(odto.getOrder_date())%>
		 </td>
		 <td align="center" width="100">
		 <!-- 주문번호를 파라미터로 갖고 주문상세페이지로 이동합니다. -->
		  <form action="orderDetail.jsp" method="post">
			<input type="hidden" name="order_number" value="<%=odto.getOrder_number()%>" /> 
			<input type="submit" value="주문상세" />
		  </form>
		 </td>
		</tr>
<%
	   }
	  }
	}
%>
		</table>
<%

			if (count > 0) {
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);

				int startPage = (int) (currentPage / 10) * 10 + 1;
				int pageBlock = 10;
				int endPage = startPage + pageBlock - 1;
				if (endPage > pageCount)
					endPage = pageCount;

				if (startPage > 10) {
		%>
		<a href="myOrder.jsp?pageNum=<%=startPage - 10%>">[이전]</a>
		<%
				}
				for (int i = startPage; i <= endPage; i++) {
		%>
		<a href="myOrder.jsp?pageNum=<%=i%>">[<%=i%>]
		</a>
		<%
				}
				if (endPage < pageCount) {
		%>
		<a href="myOrder.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
		<%
				}
			}
		%>
</center>
</body>
</html>