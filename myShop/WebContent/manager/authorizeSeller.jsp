<%@page import="myshop.shopuser.UserDAO"%>
<%@page import="myshop.shopuser.UserDTO"%>
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
		int pageSize = 10; //게시판 개수
		int currentPage = Integer.parseInt(pageNum); //현재페이지
		int startRow = (currentPage - 1) * pageSize + 1;//글첫번째
		int endRow = currentPage * pageSize;//마지막행
		int number = 0;

		String sessionId = (String) session.getAttribute("sessionId");
		if (sessionId == null) {
			response.sendRedirect("/myShop/login/loginForm.jsp");
		} else {
			UserDTO dto = new UserDTO();
			UserDAO dao = UserDAO.getInstance();
			int count = dao.waitingSellerCount(); //회사수;
			List articleList = null;
			if (count > 0) {
				articleList = dao.waitingSeller();
			}
	%>
	<center>
		<h1>
			가입 승인 대기중인 판매자
		</h1>
		</head>
		<center>
		<a href="/myShop/manager/opMain.jsp">메인으로</a><br/>
<input type="button" value="회사 관리"  onclick="location.href='/myShop/manager/companys.jsp'">
<input type="button" value="문의 내역 보기"  onclick="location.href='/myShop/manager/questionList.jsp'">
<input type="button" value="판매자 가입 신청 " onclick="location.href='/myShop/manager/authorizeSeller.jsp'">
</center>
		<b align="right">
			대기중인 내역: <%=count%>건
		</b>
		<%
			if (count == 0) {
		%>
		<table width="700" border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">내역이 없습니다.</td>
		</table>

		<%
			} else {
		%>
		<table border="1" width="700" cellpadding="0" cellspacing="0"
			align="center">
			<tr height="30">
				<td align="center" width="200">회사 이름</td>
				<td align="center" width="200">회사 번호</td>
				<td align="center" width="200">회사 자산</td>
				<td align="center" width="200">신청 날짜</td>
				<td align="center" width="200">승인</td>
			</tr>
			<%
				for (int i = 0; i < articleList.size(); i++) {
							UserDTO article = (UserDTO) articleList.get(i);
			%>
			<tr height="30">
				<td align="center" width="200"><%=article.getUser_id()%></td>
				<td align="center" width="200"><%=article.getUser_phone()%></td>
				<td align="center" width="200"><%=article.getUser_cash()%></td>
				<td align="center" width="200"><%=article.getUser_date()%></td>
				<td align="center">
					<form action="authorizePro.jsp" method="post">
						<input type="hidden" name="user_id" value="<%=article.getUser_id() %>"/>
						<input type="hidden" name="currentPage" value="<%=currentPage %>"/>
						<input type="submit" value="승인하기">
					</form>
				</td>
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
		<a href="companys.jsp?pageNum=<%=startPage - 10%>">[이전]</a>
		<%
			}
					for (int i = startPage; i <= endPage; i++) {
		%>
		<a href="companys.jsp?pageNum=<%=i%>">[<%=i%>]
		</a>
		<%
			}
					if (endPage < pageCount) {
		%>
		<a href="companys.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
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