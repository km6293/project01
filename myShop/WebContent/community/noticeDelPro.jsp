<%@page import="myshop.notice.NoticeDAO"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8");%>

<%
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");
  String passwd = request.getParameter("passwd");

  NoticeDAO dao = NoticeDAO.getInstance();
  dao.deleteArticle(num);
%>	
	<script language="JavaScript">      
      <!--      
        alert("삭제되었습니다.");
      -->
     </script>
	  <meta http-equiv="Refresh" content="0;url=noticeList.jsp?pageNum=<%=pageNum%>" >
