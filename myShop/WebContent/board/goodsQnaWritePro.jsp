<%@page import="myshop.qnaboard.QnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dto" scope="page" class="myshop.qnaboard.QnaDTO">
	<jsp:setProperty name="dto" property="*" />
</jsp:useBean>

<%
	dto.setReg_date(new Timestamp(System.currentTimeMillis()));
	
	QnaDAO dao = QnaDAO.getInstance();
	dao.insertQna(dto);
	
	response.sendRedirect("goodsDetail.jsp?goods_code=" + dto.getGoods_code());
%>
