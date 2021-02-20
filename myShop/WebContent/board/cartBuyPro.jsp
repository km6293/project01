<%@page import="myshop.goods.StoreDAO"%>
<%@page import="myshop.goods.StoreDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="myshop.shoporder.OrderDTO"%>
<%@ page import="myshop.shoporder.OrderDAO"%>
<%@ page import="myshop.cart.CartDAO"%>
<%@ page import="myshop.cart.CartDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	request.setCharacterEncoding("UTF-8");
	String sessionId = (String) session.getAttribute("sessionId");
	int remain = Integer.parseInt(request.getParameter("remain"));
	String[] goods_code = request.getParameterValues("goods_code");
	String[] cartCheck = request.getParameterValues("cartCheck");

	List cartList = null;
	OrderDAO o_dao = OrderDAO.getInstance();
	CartDAO c_dao = CartDAO.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	Date date = new Date();
	String strToday = (String) sdf.format(date);
	cartList = c_dao.getCartList(sessionId);
%>
<jsp:useBean id="order" class="myshop.shoporder.OrderDTO" />
<jsp:setProperty name="order" property="*" />

<%
	//    String odrNum = "ms"+ today+odn;
	String track = "temp";
	int odn = o_dao.getNewOrderNumber(sessionId); // 주문번호 생성	
	for (int i = 0; i < cartCheck.length; i++) { //for문 돌려서 각 물품 반복
		CartDTO cart = (CartDTO) cartList.get(Integer.parseInt(cartCheck[i])-1); // 장바구니에서 체크했던 물품만 dto에 담기
		order.setGoods_code(cart.getGoods_code()); 
		order.setUser_id(sessionId);
		order.setTrack(track);
		order.setGoods_brand(cart.getGoods_brand());
		order.setAmount(cart.getAmount());
		order.setTotal_price(cart.getGoods_price()*cart.getAmount());
		o_dao.insertOrder(order, odn); // 주문DB에 넣기
		
		 StoreDAO sdao = StoreDAO.getInstance(); //StoreDAO생성
	      StoreDTO sdto = new StoreDTO();//StoreDTO생성
	      
	      int amount = order.getAmount(); //주문된 수량을 amount변수에 저장
	      int a = sdao.sumAmount(cart.getGoods_code()); 
	      int b = a + amount;
	      sdao.updateAmount(b,cart.getGoods_code()); //추가된 수량을 업데이트  
	      
	      sdao.updateCount(amount,cart.getGoods_code()); //구매한 수량만큼 전체갯수 줄어듬

	      
	      
		o_dao.updateCash(order); // 각 물건 판매자 캐시 더하기
		c_dao.deleteCart(sessionId, cart.getGoods_code()); //장바구니에서 주문한 품목 삭제
	}
	o_dao.updateCash(remain, sessionId); //내 캐시 깎기
%>
<script>
		alert("주문이 완료되었습니다. \n주문번호: <%=odn%>");
</script>
<meta http-equiv="Refresh" content="0;url=/myShop/member/cartList.jsp">