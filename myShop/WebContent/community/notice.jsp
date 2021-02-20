<%@page import="myshop.notice.NoticeDTO"%>
<%@page import="myshop.notice.NoticeDAO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.util.Arrays" %>

<html>
<head>
<%@ include file="/include/top.jsp"%>
<title>공지사항</title>
<script language="JavaScript" src="script.js"></script>
</head>

<%
	String strNum = request.getParameter("num");
	int num =0;	
	if(strNum != null)
		num = Integer.parseInt(strNum);
	
   String pageNum = request.getParameter("pageNum");
   String content = request.getParameter("content");
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

   if(pageNum != null)//오류 처리   
   {
		
      NoticeDAO dao = NoticeDAO.getInstance();
      NoticeDTO notice =  dao.getNotice(num);
%>
<body>
<center><b>글내용 보기</b><br />
<br>
<form>
<table width="500" border="1" cellspacing="0" cellpadding="0" align="center">  
 <tr height="30">
    <td align="center" width="125">공지번호</td>
    <td align="center" width="125" align="center">
	     <%=notice.getNoti_num()%></td>
    <td align="center" width="125">조회수</td>
    <td align="center" width="125" align="center">
	     <%=notice.getNoti_readcount()%></td>
</tr>
 <tr height="30">
    <td align="center" width="125">작성자</td>
    <td align="center" width="125" align="center">
	     관리자</td>
    <td align="center" width="125">작성일</td>
    <td align="center" width="125" align="center">
	     <%= sdf.format(notice.getNoti_date())%></td>
  </tr>
  <tr height="30">
    <td align="center" width="125">글제목</td>
    <td align="center" width="375" align="center" colspan="3">
	     <%=notice.getNoti_subject()%></td>
  </tr>
  <tr>
    <td align="center" width="125">글내용</td>
    <td align="left" width="375" colspan="3"><input type="hidden" name="noticeFile" value="<%=notice.getNoti_file()%>" />
	<%
	String str = notice.getNoti_file();
	if(str != null)
	{
		String ex = str.substring(str.length()-4, str.length());
		final String[] UPLOADABLE_FILE_EXTENSION = {".png", ".jpg", "jpeg", ".bmp", ".gif", ".PNG", ".JPG", "JPEG", ".BMP", ".GIF"};
		boolean isImg = Arrays.asList(UPLOADABLE_FILE_EXTENSION).contains(ex);
		if(isImg == true)
		 {
	%>
		 	<img src="/myShop/imgsave/comimg/<%=notice.getNoti_file()%>" width="375" />
		 <%
		 }
		 %>
	<%
	}
	 %>
	 
    <pre><%=notice.getNoti_content()%></pre></td>

  </tr>
  <tr height="30">      
    <td colspan="4" align="right" >
        	<%
    	String sessionId = (String)session.getAttribute("sessionId");
    	if(sessionId != null){
    	 if(sessionId.equals("admin")){ %>
	  <input type="button" value="글수정" 
       onclick="document.location.href='noticeUpdate.jsp?num=<%=notice.getNoti_num()%>&pageNum=<%=pageNum%>'">
	   &nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="button" value="글삭제" 
       onclick="document.location.href='noticeDelPro.jsp?num=<%=notice.getNoti_num()%>&pageNum=<%=pageNum%>'">
	   &nbsp;&nbsp;&nbsp;&nbsp;
	   <%}
	   }
	   if(content==null){
	   %><input type="button" value="글목록" 
       onclick="document.location.href='noticeList.jsp?pageNum=<%=pageNum%>'">
       <%} else {%>
       <input type="button" value="글목록" 
       onclick="document.location.href='commuList.jsp?pageNum=<%=pageNum%>'">
       <%}
   }else{%>
	   <meta http-equiv="Refresh" content="0;url=/myShop/community/noticeList.jsp">
   <% }%>
    </td>
  </tr>
</table>  
</form>      
</body>
</html>      

<br /><br /><br /><br /><br />
<%@ include file="/include/bottom.jsp" %> <!--하단 -->