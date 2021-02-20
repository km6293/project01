<%@page import="myshop.goodscmt.CmtDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dto" scope="page" class="myshop.goodscmt.CmtDTO">
<jsp:setProperty name="dto" property="*" />
</jsp:useBean>

<%
    dto.setReg_date(new Timestamp(System.currentTimeMillis()));
%>

<%
	CmtDAO dao= CmtDAO.getInstance();
	dao.insertCmt(dto);
	
    response.sendRedirect("goodsDetail.jsp?goods_code=" + dto.getGoods_code());
%>
	