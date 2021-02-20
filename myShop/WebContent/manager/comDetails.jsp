<%@page import="myshop.goods.StoreDTO"%>
<%@page import="myshop.goods.StoreDAO"%>
<%@page import="myshop.shopuser.UserDAO"%>
<%@page import="myshop.shopuser.UserDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>


<%

	String user_id = request.getParameter("user_id");
	UserDAO userdao = UserDAO.getInstance();
	UserDTO userdto = userdao.usersselect("2", user_id);
    String goods_brand = user_id;
    if(goods_brand==null) {
%>
   <script>
      alert("로그인 후 이용 가능합니다");
      window.location='/myShop/login/loginForm.jsp';
    </script>	

<%} %>

<%  int pageSize = 10; //상품메인에 보여지는 상품개수
    String pageNum = request.getParameter("pageNum"); 
    if(pageNum == null){
       pageNum = "1";
    }
   
    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize +1;
    int endRow = currentPage * pageSize;
    int count = 0;
    int number = 0;
    
   
    String choice = request.getParameter("choice");
   	String search = request.getParameter("search");
	
	List albumList = null; 
	StoreDAO dao = StoreDAO.getInstance();
	
	
	if(choice != null && search != null){ //조건선택하고 검색
	 
	count = dao.getAlbumCount(goods_brand,choice,search);
		if(count > 0){
		albumList = dao.getAlbums(startRow,endRow,goods_brand,choice,search); 
		}
	}else{
	count = dao.getAlbumCount(goods_brand); 
		if(count > 0){
			albumList = dao.getAlbums(goods_brand,startRow,endRow);  
		}
	}
   
	number = count-(currentPage-1)*pageSize;   
  
    count = dao.getAlbumCount(goods_brand); //1.메소드
    if(count > 0){
	    albumList = dao.getAlbums(goods_brand,startRow,endRow); //2.메소드 
    }
    number = count-(currentPage-1)*pageSize;   
%>

<html>
<head>
<title>내 상품 메인</title>
</head>
<body>
<center>
<a href="/myShop/manager/opMain.jsp">메인으로</a><br/>
<input type="button" value="회사 관리"  onclick="location.href='/myShop/manager/companys.jsp'">
<input type="button" value="문의 내역 보기"  onclick="location.href='/myShop/manager/questionList.jsp'">
<input type="button" value="판매자 가입 신청 " onclick="location.href='/myShop/manager/authorizeSeller.jsp'">
</center>
<br/>
<table width="100%">
<tr>
	<td align = "right">
</table>
회사 주소 : <%=userdto.getUser_address() %><br>
사업자 번호 : <%=userdto.getBusiness_num() %><br>
전화번호 : <%=userdto.getUser_phone() %><br>
이메일 : <%=userdto.getUser_email() %><br>
가입 날짜: <%=userdto.getUser_date() %><br>


<%
	if(count == 0){ //등록된 상품이 없을때
%>
<table width="100%" border="1" cellpadding="0" cellespacing="0" align="center">
	<tr height="90">
		<td align = "center">
		등록된 상품이 없습니다.
		</td>
	</tr>
</table>

<% }else { %> 
<table border="1" width="100%" cellpadding="0" cellspacing="0" align="center">		
	<tr>
		<td align="center" width="5%%" > 번호 </td>
		<td align="center" width="50%" > 상품사진  </td>
		<td align="center" width="25%" > 상품이름 </td>
		<td align="center" width="20%" > 상품가격 </td>
	</tr>
<%
		for(int i = 0; i < albumList.size() ; i++){
			StoreDTO dto = (StoreDTO)albumList.get(i); 
%>	
	<tr>
		
		<td align="center" width="10" height="15"><%=dto.getGoods_code() %></td>
		
		<td align="center" width="50" height="15">
		
		<a><img style="height: 200px; width: 300px " src="/myShop/imgsave/sellerimg/<%=dto.getGoods_img() %>"></a></td>
		
		
		<td align="center" width="10" height="15">
		
		<a><%=dto.getGoods_name() %></a></td>
		
		
		<td align="center" width="10" height="15"><%=dto.getGoods_price()%></td>
		 
	</tr>
		<%} %>

</table>
<%} %>

<%
	if(count > 0){ 
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1); 
		
		
		int startPage = (int)(currentPage/10)*10+1; 
		int pageBlock=10;
		int endPage = startPage + pageBlock-1; 
		if(endPage > pageCount) endPage = pageCount;
		
		if(startPage > 10){ %> 
		<a href="sellerStore.jsp?pageNum=<%=startPage - 10 %>">[이전]</a> 
<% 		}
		for(int i = startPage ; i <= endPage ; i++) { %>
		<a href="sellerStore.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<% 		
		}
		if(endPage < pageCount){ %>
		<a href="sellerStore.jsp?pageNum=<%=startPage + 10 %>">[다음]</a>
<% 
		}
	}
%>



</body>
</html>
