<%@page import="myshop.goods.StoreDTO"%>
<%@page import="myshop.goods.StoreDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myshop.shoporder.OrderDTO"%>
<%@ page import="myshop.shoporder.OrderDAO"%>
<%@ page import="myshop.cart.CartDAO"%>
<%@ page import="myshop.cart.CartDTO"%>
<%@ page import="java.util.List" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
    
   <%request.setCharacterEncoding("UTF-8");
    String sessionId = (String)session.getAttribute("sessionId");
    int remain = Integer.parseInt(request.getParameter("remain"));
    String goods_brand = request.getParameter("goods_brand");
    
    
    
	OrderDAO o_dao = OrderDAO.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	Date date = new Date();
	String today = (String)sdf.format(date);

	
   %>
   <jsp:useBean id="order" class="myshop.shoporder.OrderDTO" />
   <jsp:setProperty name="order" property="*" />
      
   <% 
   int odn = o_dao.getNewOrderNumber(sessionId);
   //String odrNum = "ms"+ today+odn;
   String track = "temp";
   
   order.setUser_id(sessionId);
   order.setTrack(track);
   o_dao.insertOrder(order,odn);
   o_dao.updateCash(remain, sessionId);
   o_dao.updateCash(order);
   
   String code = request.getParameter("goods_code");
   int goods_code = Integer.parseInt(code);
   System.out.println(goods_code);
  
   StoreDAO sdao = StoreDAO.getInstance(); //StoreDAO생성
   StoreDTO sdto = new StoreDTO();//StoreDTO생성
  
   int amount = order.getAmount(); //주문된 수량을 amount변수에 저장
   System.out.println("지금 구매한 수량 "+amount);
   int a = sdao.sumAmount(goods_code); 
   System.out.println("구매전 판매된 수량 "+a);
   int b = a + amount;
   sdao.updateAmount(b,goods_code); //추가된 수량을 업데이트  
   System.out.println("구매후 판매된 수량 "+b);
   
   sdao.updateCount(amount,goods_code); //구매한 수량만큼 전체갯수 줄어듬
   

   %>       
	 <script>
	 	alert("주문이 완료되었습니다.\n주문번호: <%=odn%>");
	</script>
	<meta http-equiv="Refresh" content="0;url=/myShop/member/myOrder.jsp">