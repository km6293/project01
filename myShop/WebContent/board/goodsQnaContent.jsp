<%@page import="myshop.qnaboard.QnaDTO"%>
<%@page import="myshop.qnaboard.QnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import = "myshop.shopuser.*" %>
<%@ page import = "myshop.goods.*" %>

<%
   String sessionId = (String)session.getAttribute("sessionId");
   String goods_code = request.getParameter("goods_code");
   int code = 0;
   code = Integer.parseInt(goods_code);
   
   int num = Integer.parseInt(request.getParameter("num"));
   String pageNum = request.getParameter("pageNum");

   SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm");

   try{
      QnaDAO dao = QnaDAO.getInstance();
      QnaDTO dto = dao.getQna(num);
  
     int ref=dto.getRef();
     int re_step=dto.getRe_step();
     int re_level=dto.getRe_level();
%>

<center><b>글내용 보기</b></br>
<form>
<table width="500" border="1" cellspacing="0" cellpadding="0" align="center">  
  <tr height="30">
    <td align="center" width="125">글번호</td>
    <td align="center" width="125" align="center">
        <%=dto.getNum()%></td>
    <td align="center" width="125">조회수</td>
    <td align="center" width="125" align="center">
        <%=dto.getReadcount()%></td>
  </tr>
  <tr height="30">
    <td align="center" width="125">작성자</td>
    <td align="center" width="125" align="center">
        <%=dto.getWriter()%></td>
    <td align="center" width="125">작성일</td>
    <td align="center" width="125" align="center">
        <%= sdf.format(dto.getReg_date())%></td>
  </tr>
  <tr height="30">
    <td align="center" width="125">글제목</td>
    <td align="center" width="375" align="center" colspan="3">
        <%=dto.getSubject()%></td>
  </tr>
  <tr>
    <td align="center" width="125">글내용</td>
    <td align="left" width="375" colspan="3"><pre><%=dto.getContent()%></pre></td>
  </tr>
  <tr height="30">      
    <td colspan="4" align="right" > 
    
<%
   
     if(sessionId != null){
        if(sessionId.equals(dto.getWriter())){
     %>
     <input type="button" value="글수정" 
       onclick="document.location.href='goodsQnaUpdate.jsp?goods_code=<%=goods_code%>&num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'">
      &nbsp;&nbsp;&nbsp;&nbsp;
     <input type="button" value="글삭제" 
       onclick="document.location.href='goodsQnaDelete.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>&goods_code=<%=goods_code%>'">
      &nbsp;&nbsp;&nbsp;&nbsp;
     <%}
        %>
     <% 
     MyShopDAO dao2 = MyShopDAO.getInstance();
     MyShopDTO dto2 = dao2.detailGoods(code);
     	 
     if(sessionId.equals(dto2.getGoods_brand())){
     %>
      <input type="button" value="답글쓰기" 
       onclick="document.location.href='goodsQnaWrite.jsp?goods_code=<%=goods_code%>&num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
      &nbsp;&nbsp;&nbsp;&nbsp;
      <% 
     }
     }
      %>
      
       <input type="button" value="글목록" 
       onclick="document.location.href='goodsDetail.jsp?goods_code=<%=goods_code%>&pageNum=<%=pageNum%>'">
    </td>
  </tr>
</table>    
<%
   
 }catch(Exception e){} 
 %>
</form>      
</body>
</html>