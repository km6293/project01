<%@page import="myshop.community.CommunityDAO"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8");%>

<%
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");
  String passwd = request.getParameter("passwd");
  String state = request.getParameter("state");
	
  CommunityDAO dao = CommunityDAO.getInstance();
  dao.deleteCommu(num);
%> 
	<script>
		alert("삭제 되었습니다.");
	</script>
	  <meta http-equiv="Refresh" content="0;url=commuList.jsp?pageNum=<%=pageNum%>" >
