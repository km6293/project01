<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "myshop.goods.*" %>
<%@ page import = "myshop.shopuser.*" %>


<h1><center> 상품 상세 게시판</h1>

<script language="JavaScript">
<!--
function check(no){
   if (no == 1){ 
      document.form.action = "/myShop/member/cartInsertPro.jsp";
    }else if (no == 2){
         document.form.action = "buyForm.jsp";
    }else{
      return;
    }document.form.submit();
}
//-->
</script>

<%
   String cmtPageNum = request.getParameter("cmtPageNum");
   if(cmtPageNum == null) {
   cmtPageNum = "1";  
   }
   
	String goods_brand = (String)session.getAttribute("sessionId");
    String goods_code = request.getParameter("goods_code");
    int code =0;
    code = Integer.parseInt(goods_code);
   
   String pageNum = request.getParameter("pageNum");
   if(pageNum == null) {
      pageNum = "1";
      
      }
      MyShopDAO dao = MyShopDAO.getInstance();
      MyShopDTO dto = dao.detailGoods(code);
      
%>

   <table border="1" align="center">
   <form name="form" action="/myShop/member/cartInsertPro.jsp" method="post">
   <col style="width:px;">
   <tbody>
      <tr>
      <th><%=dto.getGoods_name()%></th>
      <input type="hidden" size="50"  name="user_id" value="<%=goods_brand%>">
      <input type="hidden" size="50"  name="goods_name" value="<%=dto.getGoods_name() %>">
      <td><img style="width: 600px;height: 600px" src="/myShop/imgsave/sellerimg/<%=dto.getGoods_img()%>"></td>
      <input type="hidden" name="goods_img" value="/myShop/imgsave/sellerimg/<%=dto.getGoods_img()%>">
      
      <tr>
         <th>판매가</th>
         <td><%=dto.getGoods_price()%>
         <input type="hidden" size="50"  name="goods_price" value="<%=dto.getGoods_price() %>">
         </td>
         </tr>
      <tr>
         <th>상품코드</th>
         <td><%=dto.getGoods_code()%></td>
         <input type="hidden" size="50"  name="goods_code" value= "<%=dto.getGoods_code() %>">
      </tr>
      <tr>
         <th>제조사/공급사</th>
         <td><%=dto.getGoods_brand() %></td>
      </tr>
      <tr>   
         <th>남은수량</th>
         <td><%=dto.getGoods_count() %></td>
         </td>
      </tr>
      <tr>
         <th>배송비</th>
         <td><%=dto.getGoods_delivery() %></td>
      </tr>
      
      <tr>
      	<td>상품상세</td>
      	<td><%=dto.getGoods_msg()%></td>
      </tr>
      </tbody>
      </table>
      
<center>
        
      <% 
      UserDTO udto = new UserDTO();
      UserDAO udao = UserDAO.getInstance();
      UserDTO infodto = udao.myInfo(goods_brand);
      String rating = infodto.getRating();
 
      
      if(rating.equals("2")){ %>  
      <input type="button" value="수정하기" onclick="window.location='/myShop/seller/updateDetail.jsp?goods_code=<%=goods_code%>&pageNum=<%=pageNum%>'"><%}%>    
        </form>
      <button onclick="window.location='sellerStore.jsp'">목록보기</button>   

   
    </center>
