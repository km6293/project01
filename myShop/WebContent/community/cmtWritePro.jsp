<%@page import="myshop.cmu_comment.CommentDAO"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8");%>

    <jsp:useBean id="comment" scope="page" class="myshop.cmu_comment.CommentDTO" />
    <jsp:setProperty name="comment" property="*"/>
     
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	comment.setCmt_date(new Timestamp(System.currentTimeMillis()) );
	CommentDAO dao = CommentDAO.getInstance();
	dao.insertCmt(num, comment);
%> 
<script>
	alert("댓글이 등록되었습니다.");
</script>
<meta http-equiv="Refresh" content="0;url=community.jsp?num=<%=num %>&pageNum=<%=pageNum%>" >
