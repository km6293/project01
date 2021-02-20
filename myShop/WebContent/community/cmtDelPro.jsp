<%@page import="myshop.cmu_comment.CommentDAO"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8");%>

<%
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");  
  int cmt_num = Integer.parseInt(request.getParameter("cmt_num"));
  String state = request.getParameter("state");
	
  CommentDAO dao = CommentDAO.getInstance();
  dao.deleteComment(cmt_num);
%>
	<script>
		alert("삭제 되었습니다.");
	</script>
	  <meta http-equiv="Refresh" content="0;url=community.jsp?num=<%=num%>&pageNum=<%=pageNum%>" >
