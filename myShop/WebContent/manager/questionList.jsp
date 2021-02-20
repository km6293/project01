<%@page import="myshop.opboard.OpBoardDTO"%>
<%@page import="myshop.opboard.OpBoardDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title> 
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String pageNum = request.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		}
		int pageSize = 5; //게시판 개수
		int currentPage = Integer.parseInt(pageNum); //현재페이지
		int start = (currentPage - 1) * pageSize + 1;//글첫번째
		int end = currentPage * pageSize;//마지막행 페이지 x 페이지개수
		// 	 int number = 0;
		List articleList = null;

		String sessionId = (String) session.getAttribute("sessionId");
		if (sessionId == null) {
			response.sendRedirect("/myShop/login/loginForm.jsp");
		} else {

			OpBoardDAO dao = OpBoardDAO.getInstance();
			int count = dao.getInquiry();
			if (count > 0) {
				articleList = dao.selectInquiry(start, end);
				
			}
	%>
	<center>
	<h1>문의 내용</h1>
</head>
<center>
<a href="/myShop/manager/opMain.jsp">메인으로</a><br/>
<input type="button" value="회사 관리"  onclick="location.href='/myShop/manager/companys.jsp'">
<input type="button" value="문의 내역 보기"  onclick="location.href='/myShop/manager/questionList.jsp'">
<input type="button" value="판매자 가입 신청 " onclick="location.href='/myShop/manager/authorizeSeller.jsp'">
</center>
<b>답변 안한 문의 수 : <%=count%></b>
<%
	if (count <= 0) {
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center">문의 내역을 전부 해결했습니다.</td>
</table>

<%
	} else {
%>
<table border="1" width="700" cellpadding="0" cellspacing="0"
	align="center">
	<tr height="30">
		<td align="center" width="200">작성자</td>
		<td align="center" width="200">제목</td>
		<td align="center" width="200">이메일</td>
		<td align="center" width="200">IP주소</td>
	</tr>
	<%
		for (int i = 0; i < articleList.size(); i++) {
		
		OpBoardDTO article = (OpBoardDTO) articleList.get(i);
		
	%>
	<tr height="30">
		<td align="center" width="200"><a
			href="/myShop/manager/questionDetails.jsp?num=<%=article.getOp_idx()%>&pageNum=<%=pageNum%>"><%=article.getOp_id()%></a></td>
		<td align="center" width="200"><a
			href="/myShop/manager/questionDetails.jsp?num=<%=article.getOp_idx()%>&pageNum=<%=pageNum%>"><%=article.getOp_title()%></a></td>
		<td align="center" width="200"><a
			href="/myShop/manager/questionDetails.jsp?num=<%=article.getOp_idx()%>&pageNum=<%=pageNum%>"><%=article.getOp_email()%></a></td>
		<td align="center" width="200"><a
			href="/myShop/manager/questionDetails.jsp?num=<%=article.getOp_idx()%>&pageNum=<%=pageNum%>"><%=article.getOp_ip()%></a></td>
	</tr>
	<%	
		}
	%>
</table>
<%
	}
%>

<%
	if (count > 0) {
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);

			int startPage = (int) (currentPage / 10) * 10 + 1;
			int pageBlock = 10;
			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount)
				endPage = pageCount;

			if (startPage > 10) {
%>
<a href="questionList.jsp?pageNum=<%=startPage - 10%>">[이전]</a>
<%
	}
			for (int i = startPage; i <= endPage; i++) {
%>
<a href="questionList.jsp?pageNum=<%=i%>">[<%=i%>]
</a>
<%
	}
			if (endPage < pageCount) {
%>
<a href="questionList.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
<%
	}
		}
%>
</center>
</body>
<%
	}
%>
</html>