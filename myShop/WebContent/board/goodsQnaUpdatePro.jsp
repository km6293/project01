<%@page import="myshop.qnaboard.QnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="dto" class = "myshop.qnaboard.QnaDTO">
	<jsp:setProperty name = "dto" property="*"/>
</jsp:useBean>

<%
	String goods_code = request.getParameter("goods_code");
    String pageNum = request.getParameter("pageNum");
	System.out.print(dto.getGoods_code() + "//getGoods_code");
	QnaDAO dao = QnaDAO.getInstance();
    int check = dao.updateQna(dto);

    if(check==1){
%>
	  <meta http-equiv="Refresh" content="0;url=goodsQnaList.jsp?goods_code=<%=goods_code%>&pageNum=<%=pageNum%>" >
<% }else{%> /
      <script language="JavaScript">      
      <!--      
        alert("비밀번호가 맞지 않습니다");
        history.go(-1);
      -->
     </script>
<%
    }
    
    response.sendRedirect("goodsDetail.jsp?goods_code=" + dto.getGoods_code());
 %>  
