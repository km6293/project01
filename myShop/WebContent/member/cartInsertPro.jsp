<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myshop.cart.CartDAO" %>


    <%request.setCharacterEncoding("UTF-8");
    String sessionId = (String)session.getAttribute("sessionId");%>
	<jsp:useBean id="dto" class="myshop.cart.CartDTO" />
    <jsp:setProperty property="*" name="dto"/> 
    
    <%
	CartDAO dao = CartDAO.getInstance();
    int chk = dao.cartCheck(sessionId, dto.getGoods_code());
    
    if(sessionId==null)
  	{
%>
	<script>
      alert("로그인 후 이용 가능합니다");
      window.location='/myShop/login/loginForm.jsp';
     </script>

<%}
    
	if(chk == 0){
	    dao.insertCart(dto);
    %>
	<script>
		alert("장바구니에 담겼습니다.");
		history.go(-1);
	</script>
	<%}else{%>
	<script>
		alert("장바구니에 동일한 상품이 존재합니다.");
		history.go(-1);
	</script>
	<%} %>