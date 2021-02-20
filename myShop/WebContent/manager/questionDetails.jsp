<%@page import="myshop.opboard.OpBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "myshop.opboard.OpBoardDTO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의내역상세</title>
</head>
<%
   int num = Integer.parseInt(request.getParameter("num"));
   String pageNum = request.getParameter("pageNum");
//    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

   try{ 
      OpBoardDAO dao = OpBoardDAO.getInstance();
      OpBoardDTO notice =  dao.getNotice(num);
   
%>
<center>
<body>
	<table width="500" border="1" align="center">
		<tr>
			<td width="50%">글번호</td>
			<td><%=notice.getOp_idx() %>
			</td>
		</tr>
		<tr>
		<tr>
			<td>작성자</td>
			<td><%=notice.getOp_id() %>
			</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><%=notice.getOp_email() %>
			</td>
		</tr>
		<tr>
			<td>글제목</td>
			<td><%=notice.getOp_title() %>
			</td>
		</tr>
		<tr>
			<td height="200">글내용</td>
			<td><pre><%=notice.getOp_content() %></pre>
			</td>
		</tr>
	</table>
	
	<button onclick="window.location='/myShop/manager/questionList.jsp'" >돌아가기</button>
	<a href="mailForm.jsp?email=<%=notice.getOp_email()%>&idx=<%=notice.getOp_idx()%>">답장</a>
	
	
	</center>
	<%
	}catch(Exception e){} 
	%>
</body>
</html>