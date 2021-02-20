<%@page import="myshop.goodscmt.CmtDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>

<jsp:useBean id="dto" scope="page" class="myshop.goodscmt.CmtDTO">
	<jsp:setProperty name="dto" property="*" />
</jsp:useBean>
<%
  String goods_code = request.getParameter("goods_code");
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("cmtPageNum");
  CmtDAO dao = CmtDAO.getInstance();
  dao.deleteCmt(num);
  
%>
	<script>
		alert("삭제 되었습니다.");
	</script>
	
	<meta http-equiv="Refresh" content="0;url=goodsDetail.jsp?goods_code=<%=goods_code%>">