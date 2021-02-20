<%@page import="myshop.goods.GoodsDTO"%>
<%@page import="myshop.goods.GoodsDAO"%>
<%@page import="myshop.shoporder.OrderDAO"%>
<%@page import="myshop.contact.ContactDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>contactForm페이지입니다.</h1>
<script language="javascript">
<!-- 
function checkFile(f){

	// files 로 해당 파일 정보 얻기.
	var file = f.files;

	// file[0].name 은 파일명 입니다.
	// 정규식으로 확장자 체크
	if(!/\.(gif|jpg|jpeg|png)$/i.test(file[0].name)) alert('gif, jpg, png 파일만 선택해 주세요.');

	// 체크를 통과했다면 종료.
	else return;

	// 체크에 걸리면 선택된  내용 취소 처리를 해야함.
	// 파일선택 폼의 내용은 스크립트로 컨트롤 할 수 없습니다.
	// 그래서 그냥 새로 폼을 새로 써주는 방식으로 초기화 합니다.
	// 이렇게 하면 간단 !?
	f.outerHTML = f.outerHTML;
}
-->
</script>
<%
	//세션 획득
    String userId = (String)session.getAttribute("sessionId");
    
	//로그인되어 있지 않으면 loginForm.jsp파일로 리디렉트합니다.
    if(userId==null){response.sendRedirect("loginForm.jsp");}
	
	//OrderDAO,GoodsDAO의 인스턴스 획득
    OrderDAO odao = OrderDAO.getInstance();
	GoodsDAO gdao = GoodsDAO.getInstance();
	

	int num = 0;
	String title = "문의하기";
	GoodsDTO gdto  = new GoodsDTO();
	//문의할 주문의 주문번호와 상품이름 파라미터 획득
    int order_number= Integer.parseInt(request.getParameter("order_number"));
	
	int goods_code=0;
	if(request.getParameter("goods_code")!=null){
		goods_code = Integer.parseInt(request.getParameter("goods_code"));
		gdto = gdao.goodsDetail(goods_code);
	}
	
	//답변이 아니라면 구매자가 직접 접근하는지 확인
		boolean result = odao.contactCheck(order_number, userId);
		if(result==false) {
%>
<!-- 경고참과 함께 주문목록으로 리디렉트합니다. -->
<script>
	alert("본인의 주문이 아닙니다.");
	window.location="/member/myOrder.jsp";
</script>	
<%
		}
	try{
%>
<html>
<head>
<title><%=title %></title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js">
</script>
</head>
   
<body> 
<%@ include file="/include/top.jsp" %> 
<center><b>작성</b>
<br>
<form method="post" name="contactForm" action="contactPro.jsp" enctype="multipart/form-data">
	<input type="hidden" name="order_number" value="<%=order_number %>"/>
	<input type="hidden" name="writer" value="<%=userId %>"/>
	<input type="hidden" name="goods_code" value="<%=goods_code %>"/>
	<%if(gdto!=null){%>
		<input type="hidden" name="goods_brand" value="<%=gdto.getGoods_brand() %>" />
	<%} %>
<table width="400" border="1" cellspacing="0" cellpadding="0" align="center">
   <tr>
    <td colspan="2" width="400" align="center">
    <%if(gdto!=null&&gdto.getGoods_name()!=null){ %>
       <%=gdto.getGoods_name()%>
    <%}else{ %>
   		 존재하지 않는 상품
    <%} %>
    </td>
  </tr>
  <tr>
    <td  width="120"  align="center" >
       제 목
    </td>
    <td  width="330">
       <input type="text" size="40" maxlength="50" name="subject">
    </td>
  </tr>
  <tr>
   <td  align="center">
    Email
   </td>
   <td  width="330">
    <input type="text" size="40" maxlength="30" name="email" >
   </td>
  </tr>
  <tr>
   <td  align="center" >
      내 용
   </td>
   <td  width="330" >
    <textarea name="content" rows="13" cols="40"></textarea> 
   </td>
  </tr>
  <tr>
   <td align="center">
  	파일첨부
   </td>
   <td align="center"> 
  	<input type="file" name="filename" onchange = "checkFile(this)"/><br>
   </td>
  </tr>
  <tr>
   <td colspan=2  align="center"> 
    <input type="submit" value="문의하기" >  
    <input type="reset" value="다시작성">
  	<input type="button" value="문의내역" OnClick="window.location='contactList.jsp'">
   </td>
  </tr>
</table>
<%
  }catch(Exception e){}
%>     
</form>      
</body>
</html>      
