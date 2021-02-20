<%@page import="myshop.notice.NoticeDTO"%>
<%@page import="myshop.notice.NoticeDAO"%>
<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>


<%!
    int pageSize = 10;
    SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd");
    Date date = new Date();
    String today = (String)sdf.format(date);
%>

<%
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1; 
    int endRow = currentPage * pageSize;	
    int count = 0;
    int number=0;
     
	String sessionId = (String) session.getAttribute("sessionId");
    List noticeList = null;
    NoticeDAO dao = NoticeDAO.getInstance(); 
    count = dao.getNoticeCount(); 
    if (count > 0) {
        noticeList = dao.getNotices(startRow, endRow); 
    }
	number=count-(currentPage-1)*pageSize; 
	
%>
<html>
<head>
<title>공지사항</title>
</head>
<body>
<%@ include file="/include/top.jsp"%>
	<center>
	<br/>
	<table border="1" style="width: 400;height: 50; text-align: center;">
		<tr>
		<td><a href="/myShop/community/commuList.jsp">자유게시판</a></td>
		<td><a href="/myShop/community/noticeList.jsp">공지게시판</a></td>
		</tr>
	</table>
	<br/>
<b>공지사항</b> 
<br/>
<br/>
<table width="700">
<tr>
    <td align="right">
    <% if(sessionId == null){ %>
		<a href="/myShop/login/loginForm.jsp">로그인</a>
    <% }else if(rating1.equals("5")){%>
    	<a href="noticeWrite.jsp">글쓰기</a>
     <%}else{%>
    <%}%>
    </td>
   
</table>


<%
    if (count == 0) { 
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
    <td align="center">
    공지사항이 없습니다.
    </td>
</table>

<%  } else {%> 
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30"> 
      <td align="center"  width="50"  >번 호</td> 
      <td align="center"  width="250" >제   목</td> 
      <td align="center"  width="150" >작성일</td> 
      <td align="center"  width="50" >조회수</td> 
    </tr>
<%  
        for (int i = 0 ; i < noticeList.size() ; i++) {
          NoticeDTO notice = (NoticeDTO)noticeList.get(i); 
%>
    <tr height="30">
    <td align="center" width="50" >공지</td>
    <td align="center" width="250" > 
    
    	<a href="notice.jsp?num=<%=notice.getNoti_num()%>&pageNum=<%=currentPage%>">
    	<%=notice.getNoti_subject()%></a>
    	<% if(notice.getNoti_file() != null){%>
         <img src="/myShop/dev_img/file.png" border="0"  height="16"><%}%>
        <% if(today.equals(sdf.format(notice.getNoti_date()))){
%>
		<img src="/myShop/dev_img/new.jpg" border="0"  height="16"><%}%></td>
    <td align="center" width="150"><%= sdf.format(notice.getNoti_date())%></td> 
    <td align="center" width="50"><%=notice.getNoti_readcount()%></td>				
  </tr>
     <%}%>
</table>
<%}%>

<%
    if (count > 0) { 
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1); 
		 
        int startPage = (int)(currentPage/10)*10+1; 
		int pageBlock=10;
        int endPage = startPage + pageBlock-1;
        
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {  %>
        <a href="noticeList.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) { %>
        <a href="noticeList.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%
        }
        if (endPage < pageCount) { %>
        <a href="noticeList.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>
</center>
</body>
</html>
<br /><br /><br /><br /><br />
<%@ include file="/include/bottom.jsp" %> <!--하단 -->