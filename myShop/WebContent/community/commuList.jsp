<%@page import="myshop.community.CommunityDTO"%>
<%@page import="myshop.notice.NoticeDTO"%>
<%@page import="myshop.community.CommunityDAO"%>
<%@page import="myshop.cmu_comment.CommentDAO"%>
<%@page import="myshop.notice.NoticeDAO"%>
<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%!
    int pageSize = 10;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    SimpleDateFormat noti_sdf = new SimpleDateFormat("yyyy-MM-dd");
    Date date = new Date();
    String today = (String)noti_sdf.format(date);
     
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
    int del = 0;

    List commuList = null;
    List noticeList = null;
    NoticeDAO dao = NoticeDAO.getInstance(); 
    count = dao.getNoticeCount(); 
    if (count > 0) {
        noticeList = dao.getNotices(startRow, endRow); 
    }
    CommunityDAO commu = CommunityDAO.getInstance();
    CommentDAO cmt = CommentDAO.getInstance();
    count = commu.getCommuCount(); 
    if (count > 0) {
    	commuList = commu.getCommues(startRow, endRow); 
    }
	del = commu.getDelCount();
	 String sessionId = (String)session.getAttribute("sessionId");
%>
<html>
<head>

<title>자유게시판</title>
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
</head>
<body>
<center><b>자유게시판</b> 
<table width="700">
<tr>
    <td align="right">
    <%
    	if(sessionId != null){
    %>
    <a href="commuWrite.jsp">글쓰기</a>
     <%}else{%>
    <a href="/myShop/login/loginForm.jsp">로그인</a>
    <%} %>
    </td>
   
</table>

<%
    if (count == 0) { 
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
    <td align="center">
    게시판에 저장된 글이 없습니다.
    </td>
</table>

<%  } else {%> 
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30"> 
      <td align="center"  width="70"  >회원등급</td> 
      <td align="center"  width="250" >제   목</td> 
      <td align="center"  width="100" >작성자</td>
      <td align="center"  width="150" >작성일</td> 
      <td align="center"  width="30" >조회수</td>  
    </tr>
    
    <%  if(pageNum.equals("1")){
        for (int i = 0 ; i < 3 ; i++) {
          NoticeDTO notice = (NoticeDTO)noticeList.get(i);
%>
    <tr height="30">
    <td align="center" width="50" bgcolor="#D9E5FF">공지</td>
    <td align="center" width="250" bgcolor="#D9E5FF"> 
    	<a href="notice.jsp?num=<%=notice.getNoti_num()%>&pageNum=<%=currentPage%>&content=commu">
    	<%=notice.getNoti_subject()%></a> 
    	<% if(notice.getNoti_file() != null){%>
         <img src="/myShop/dev_img/file.png" border="0"  height="16"><%}%>
        <% if(today.equals(noti_sdf.format(notice.getNoti_date()))){
%>
		<img src="/myShop/dev_img/new.jpg" border="0"  height="16"><%}%></td>
	<td align="center"  width="100" bgcolor="#D9E5FF">관리자</td> 
    <td align="center" width="150" bgcolor="#D9E5FF"><%= noti_sdf.format(notice.getNoti_date())%></td> 
    <td align="center" width="50" bgcolor="#D9E5FF"><%=notice.getNoti_readcount()%></td>				
  </tr>
     <%}
    }
        for (int i = 0 ; i < commuList.size() ; i++) {
          CommunityDTO cm = (CommunityDTO)commuList.get(i);
          
         String c_rating = "";
  		String rating = commu.getRating(cm.getWriter());
  		if(rating.equals("1")){
  			c_rating = "일반회원";
  		}else if(rating.equals("2")){
  			c_rating= "판매자";
  		}else if(rating.equals("5")){
  			c_rating= "관리자";
  		}
    if(cm.getState() == 1){
%>
    <tr height="30">
		<td align="center"  width="50" ><%=c_rating%></td>
		<td  width="250" align="center">           
			<a href="community.jsp?num=<%=cm.getNum()%>&pageNum=<%=currentPage%>">
			<%  int cmtCount = cmt.getCommentCount(cm.getNum()); %>
            <%=cm.getSubject()%> [<%=cmtCount%>]</a> 
            <% if(cm.getReadcount()>=50){%>
            <img src="/myShop/dev_img/hot.gif" border="0"  height="16"><%}%> </td>
    <td align="center"  width="100"><%=cm.getWriter()%></td> 	
    <td align="center"  width="150"><%= sdf.format(cm.getReg_date())%></td> 
    <td align="center"  width="50"><%=cm.getReadcount()%></td>					
  </tr>
     <%}
     }%>
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
        <a href="commuList.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) { %>
        <a href="commuList.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%
        }
        if (endPage < pageCount) { %>
        <a href="commuList.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>
</center>
</body>
</html>
<br /><br /><br /><br /><br />
<%@ include file="/include/bottom.jsp" %> <!--하단 -->