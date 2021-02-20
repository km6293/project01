<%@page import="myshop.notice.NoticeDTO"%>
<%@page import="myshop.notice.NoticeDAO"%>
<%@ page contentType = "text/html; charset=UTF-8" %>
    
<html>
<head>
<title>공지사항</title>
<script language="JavaScript" src="script.js"></script>
</head>

<%
	String sessionId = (String) session.getAttribute("sessionId");
	if (!sessionId.equals("admin")) { //수정
%>
<script>
	alert("관리자만 접근 가능합니다.");
	window.location = '/myshop/community/noticeList.jsp';
</script>
<%
	}
	
	  int num = Integer.parseInt(request.getParameter("num"));
	  String pageNum = request.getParameter("pageNum");
	  try{
	      NoticeDAO dao = NoticeDAO.getInstance();
	      NoticeDTO notice =  dao.updateGetNotice(num);
%>
<body>
	<center>
		<b>글수정</b> <br>
		<form method="post" name="updateform" action="noticeUpdatePro.jsp"
			onsubmit="return writeSave()" enctype="multipart/form-data">
			<input type="hidden" name="pageNum" value="<%=pageNum %>">
			<input type="hidden" name="num" value="<%=notice.getNoti_num()%>"></td>

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
						name="subject" value="<%=notice.getNoti_subject()%>"></td>
				</tr>
				<tr>
					<td width="70" align="center">첨부파일</td>
					<td width="330"><input type="file" size="40" maxlength="50"
						name="noticeFile" value="<%=notice.getNoti_file()%>"></td>
				</tr>
				<tr>
					<td width="70" align="center">내 용</td>
					<td width="330">
					<textarea name="content" rows="13" cols="40"><%=notice.getNoti_content()%></textarea></td>
				</tr>
				<tr>
					<td colspan=2 align="center">
					<input type="submit" value="글수정">
					<input type="reset" value="다시작성"> 
					<input type="button" value="목록보기" 
						onclick="window.location.href='noticeList.jsp?pageNum=<%=pageNum%>'"></td>
				</tr>
			</table>
			</form>
			<%
				} catch (Exception e) {
				}
			%>

</body>
</html>