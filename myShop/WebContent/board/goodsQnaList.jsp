<%@page import="myshop.qnaboard.QnaDTO"%>
<%@page import="myshop.qnaboard.QnaDAO"%>
<%@page import="myshop.goods.MyShopDTO"%>
<%@page import="myshop.goods.MyShopDAO"%>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
   	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); 
	
	String sessionId = (String)session.getAttribute("sessionId");
   	String code = request.getParameter("goods_code");
	int goods_code = Integer.parseInt(code);
   	MyShopDAO mysh = MyShopDAO.getInstance();
    MyShopDTO dto = mysh.detailGoods(goods_code);
%>

<%  
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
    int number=0;

    List QnaList = null;
    QnaDAO dao = QnaDAO.getInstance();
    count = dao.getQnaCount(goods_code); 
    if (count > 0) { 
        QnaList = dao.getQnas(startRow, endRow, goods_code);
    }

   	number=count-(currentPage-1)*pageSize; 
%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<center><b><%=dto.getGoods_name() %>상품 Q&A(전체 글:<%=count%>)</b>
<table width="700">
<tr>
	
	<td align="right" >
	<%if(sessionId!=null){%>
  	<a href="goodsQnaWrite.jsp?goods_code=<%=goods_code%>&pageNum=<%=pageNum%>">글쓰기</a>
  	<%}else{ %>
    	<a href="..//login/loginForm.jsp">로그인</a>
    	 <%} %>
</td>
</tr>
</table>
   
<%
    if (count == 0) {
%>

<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
    <td align="center">
    게시판에 저장된 글이 없습니다.
    </td>
</table>

<%  } else {   %>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30"> 
      <td align="center"  width="50"  >번 호</td> 
      <td align="center"  width="250" >제   목</td> 
      <td align="center"  width="100" >작성자</td>
      <td align="center"  width="150" >작성일</td> 
      <td align="center"  width="50" >조 회</td>   
    </tr>
<%  
        for (int i = 0 ; i < QnaList.size() ; i++) {
          QnaDTO qna = (QnaDTO)QnaList.get(i);
%>
    <tr height="30">
    <td align="center"  width="50" > <%=number--%></td>
    <td  width="250" >
   <%
         int wid=0; 
         if(qna.getRe_level()>0){
           wid=5*(qna.getRe_level());
   %>
     <img src="images/level.gif" width="<%=wid%>" height="16">
   <%}else{%>
     <img src="images/level.gif" width="<%=wid%>" height="16">
   <%}%>
 	<!-- 제목 눌렀을때 상세보기로 이동 -->
      <a href="goodsQnaContent.jsp?goods_code=<%=goods_code%>&num=<%=qna.getNum()%>&pageNum=<%=currentPage%>">
           <%=qna.getSubject()%></a> 
           <% if(qna.getReadcount()>=20){%>
         <img src="images/hot.gif" border="0"  height="16"><%}%> </td>
    <td align="center"  width="100"> 
    <!-- 작성자 눌렀을때  이동-->
       <a href="goodsQnaContent.jsp?goods_code=<%=goods_code%>&num=<%=qna.getNum()%>&pageNum=<%=currentPage%>">
       <%=qna.getWriter()%></a></td>
    <td align="center"  width="150"><%= sdf.format(qna.getReg_date())%></td>
    <td align="center"  width="50"><%=qna.getReadcount()%></td>
  </tr>
  <%}%>
</table>
 <%}%>

<br>
<%
    if (count > 0) {
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
       
        int startPage = (int)(currentPage/10)*10+1;
      int pageBlock=10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {    %>
        <a href="goodsQnaList.jsp?pageNum=<%= startPage - 10 %>&goods_code=<%=goods_code%>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>
        <a href="goodsDetail.jsp?pageNum=<%= i %>&goods_code=<%=goods_code%>">[<%= i %>]</a>
<%
        }
        if (endPage < pageCount) {  %>
        <a href="goodsDetail.jsp?pageNum=<%= startPage + 10 %>&goods_code=<%=goods_code%>">[다음]</a>

<%
        }
    }
%>

</body>
</html>