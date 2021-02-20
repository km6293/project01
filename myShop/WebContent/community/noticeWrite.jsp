<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="myshop.shopuser.UserDAO" %>
<%@ page import="myshop.shopuser.UserDTO" %>
<html>
<head>
<title>공지사항</title>
<script language="JavaScript" src="script.js"></script>
</head>

<%
	String sessionId = (String) session.getAttribute("sessionId");
	UserDTO udto = new UserDTO();
	UserDAO udao = new UserDAO();
	UserDTO infodto = udao.myInfo(sessionId);
	String rating = infodto.getRating();
	System.out.println(rating);
	
	if (!rating.equals("5")) { 
%>
<script>
	alert("관리자만 접근 가능합니다.");
	window.location = '/myShop/community/noticeList.jsp';
</script>
<%
	}

	int num = 0;
	try {
		if (request.getParameter("num") != null) {
			num = Integer.parseInt(request.getParameter("num"));
		}
%>

<body>
	<center>
		<b>글쓰기</b> <br>
		<form method="post" name="writeform" action="noticeWritePro.jsp"
			onsubmit="return writeSave()" enctype="multipart/form-data">
			<input type="hidden" name="num" value="<%=num%>">

			<table width="400" border="1" cellspacing="0" cellpadding="0"
				align="center">
				<tr>
					<td align="right" colspan="2"><a href="noticeList.jsp"> 글목록</a></td>
				</tr>
				<tr>
					<td width="70" align="center">이 름</td>
					<td width="330">관리자 <input type="hidden" name="writer"
						value=<%=sessionId%>></td>
				</tr>
				<tr>
					<td width="70" align="center">제 목</td>
					<td width="330"><input type="text" size="40" maxlength="50"
						name="subject"></td>
				</tr>
				<tr>
					<td width="70" align="center">첨부파일</td>
					<td width="330"><input type="file" size="40" maxlength="50"
						name="noticeFile"></td>
				</tr>
				<tr>
					<td width="70" align="center">내 용</td>
					<td width="330"><textarea name="content" rows="13" cols="40">&nbsp;</textarea>
					</td>
				</tr>
				<tr>
					<td colspan=2 align="center"><input type="submit" value="등록">
						<input type="reset" value="다시작성"> <input type="button"
						value="목록보기" OnClick="window.location='noticeList.jsp'"></td>
				</tr>
			</table>
			<%
				} catch (Exception e) {
				}
			%>
		</form>
</body>
</html>
