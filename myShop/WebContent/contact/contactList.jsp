<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "myshop.contact.ContactDAO" %>
<%@ page import = "myshop.contact.ContactDTO" %>
<%@ page import = "myshop.goods.GoodsDAO" %>
<%@ page import = "myshop.goods.GoodsDTO" %>
<%@ page import = "myshop.shopuser.UserDAO" %>
<%@ page import = "myshop.shopuser.UserDTO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>


<%
	//로그인 상태를 확인합니다.
	String user_id = (String)session.getAttribute("sessionId");
	if(user_id==null)
	{
		response.sendRedirect("loginForm.jsp");
	}
	//판매자인지 구매자인지 확인하기 위해 RATING값을 가져옵니다.
	UserDAO udao = UserDAO.getInstance();
	UserDTO udto = new UserDTO();
	udto = udao.myInfo(user_id);
	String arating = udto.getRating();
	//rating = 1은 구매자 rating = 2는 판매자
	
	int pageSize = 10; //한 화면에 보여줄 게시글 개수
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); //게시물 작성 시간 - 날짜 출력 방식

	//기존에 보던 페이지 불러오기
	String pageNum = request.getParameter("pageNum"); //pageNum : [1], [2]..
	if (pageNum == null){
		pageNum = "1"; //요청된 값 없으면 첫페이지
	}
	
	//필요한 변수 선언
	int currentPage = Integer.parseInt(pageNum); 
	int startRow = (currentPage -1)*pageSize +1; 
	int endRow = currentPage * pageSize; 
	int count = 0; //전체 게시글 개수
	int number = 0;
	
	List contactList = null;
	
	//판매자문의DB DAO
	ContactDAO cdao = ContactDAO.getInstance();
	
	//상품DB DAO
	GoodsDAO gdao = GoodsDAO.getInstance();

	//
		//일반회원이면 writer칼럼으로 검색
		if(arating.equals("1")){
			contactList = cdao.getContactList1(user_id,startRow,endRow);
			count = cdao.getContactCount1(user_id);
		}else{//판매자면 goods_brand칼럼으로 검색
			contactList = cdao.getContactList2(user_id, startRow, endRow);
			count = cdao.getContactCount2(user_id);
		}
	number = count-(currentPage-1)*pageSize;
%>
<html>
<head>
<title>판매자 문의답변 게시판</title>
</head>
<body>
<% 			String include = null;
			if(arating.equals("1")){
				include = "/include/top.jsp";
			}else{
				include = "/seller/seller_top.jsp";
			}
%>
<jsp:include page="<%=include %>"/>
<center><b>나의 상품 문의(전체 글:<%=count %>)</b>

<%
	if(count == 0){ //문의글이 없을 때
%>
<table width="800" border="1" cellpadding="0" cellspacing="0">
<tr>
	<td align="center">
	등록된 문의글이 없습니다.
	</td>
</table>

<%	} else	{ %> 
<table border="1" width="800" cellpadding="0" cellspacing="0" align="center">
	<tr height="30" >
		<td align="center" width="30%" >주문상품 </td>
		<td align="center" width="40%" >제  목 </td>
		<td align="center" width="15%" >작성자ID </td>
		<td align="center" width="20%" >작성일 </td>
		
	</tr>
<%
		int goods_code = 0;
		
		for(int i = 0 ; i < contactList.size() ; i++){
			ContactDTO cdto = (ContactDTO)contactList.get(i);
				goods_code = cdto.getGoods_code();	
				GoodsDTO gdto = new GoodsDTO();
				gdto = gdao.goodsDetail(goods_code);
%>
	<tr height="30">
		<td align="center">
		<%
			if(gdto!=null){
		%>
			<a href="/myShop/board/goodsDetail.jsp?goods_code=<%=gdto.getGoods_code() %>">
				<%=gdto.getGoods_name() %>
			</a>
		<%	}else{ %>
			존재하지 않는 상품
		<%	} %>
		</td>
		<td>
			<%
			int wid=0;
			if(cdto.getRe_level()>0){wid=5*(cdto.getRe_level()); //답글이면 간격넣기
			%>
			<img src="images/level.gif" width="<%=wid %>" height="16"> 
			<img src="images/re.gif"> 
			<%}else{ %>	
			<img src ="images/level.gif" width="<%=wid%>" height="16">
			<%}%> 
			<a href="contactDetail.jsp?num=<%=cdto.getNum() %>&pageNum=<%=currentPage%>">
				<%=cdto.getSubject() %>
			</a>
		</td>
		<td align="center">
			<%=cdto.getWriter() %>
		</td>
		<td align="center" width="150">
			<%=sdf.format(cdto.getReg_date()) %>
		</td>
	</tr>
<%
		}
%>		
</table>

<%
	if(count > 0){ //124
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1); 
		//13 = 124/10 +  (1)
		
		int startPage = (int)(currentPage/10)*10+1; 
		int pageBlock=10;
		int endPage = startPage + pageBlock-1; 
		if(endPage > pageCount) endPage = pageCount;
		
		if(startPage > 10){ %> 
		<a href="contactList.jsp?pageNum=<%=startPage - 10 %>">[이전]</a> 
<% 		}
		for(int i = startPage ; i <= endPage ; i++) { %>
		<a href="contactList.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<% 		
		}
		if(endPage < pageCount){ %>
		<a href="contactList.jsp?pageNum=<%=startPage + 10 %>">[다음]</a>
<%
		}
	}
}
%>
</center>
</body>
</html>
	