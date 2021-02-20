<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="myshop.community.CommunityDTO"%>
<%@page import="myshop.community.CommunityDAO"%>
<%@page import="myshop.cmu_comment.CommentDAO"%>
<%@page import="myshop.cmu_comment.CommentDTO"%>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import= "java.util.List" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<style>
textarea {
	width: 100%;
	height: 100px;}
</style>
 
<html>
<head>

<title>자유게시판</title>
</head>
<body>
<%@ include file="/include/top.jsp"%>
</head>

<%
   int pageSize = 30;
	String strNum = request.getParameter("num");
	int num =0;	
	if(strNum != null)
	num = Integer.parseInt(strNum);
   
	String pageNum = request.getParameter("pageNum");
   int cmtPage = 1;
   
   SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm");
   if(pageNum != null)//오류 처리   
   {

   int currentPage = cmtPage;
   int startRow = (currentPage - 1) * pageSize + 1; 
   int endRow = currentPage * pageSize;	
   int count = 0;
   int del = 0;

   List cmtList = null;
   CommentDAO c_dao = CommentDAO.getInstance();
   count = c_dao.getCommentCount(num); 
   del = c_dao.getDelCount(num);
   if (count > 0) {
   	cmtList = c_dao.getComments(num, startRow, endRow); 
   }
	   CommunityDAO dao = CommunityDAO.getInstance();
	   CommunityDTO cm =  dao.getCommu(num);
	   
%>
<body>
<center><b>글내용 보기</b><br />
<br>
<form>
<table width="700" border="1" cellspacing="0" cellpadding="0" align="center">  
 <tr height="30">
    <td align="center" width="125">글번호</td>
    <td align="center" width="125" align="center">
	     <%=cm.getNum()%></td>
    <td align="center" width="125">조회수</td>
    <td align="center" width="125" align="center">
	     <%=cm.getReadcount()%></td>
</tr>
 <tr height="30">
    <td align="center" width="125">작성자</td>
    <td align="center" width="125" align="center">
	      <%=cm.getWriter()%></td>
    <td align="center" width="125">작성일</td>
    <td align="center" width="125" align="center">
	     <%= sdf.format(cm.getReg_date())%></td>
  </tr>
  <tr height="30">
    <td align="center" width="125">글제목</td>
    <td align="center" width="375" align="center" colspan="3">
	     <%=cm.getSubject()%></td>
  </tr>
  <tr>
    <td align="center" width="125">글내용</td>
    <td align="left" width="375" colspan="3"><pre><%=cm.getContent()%></pre></td>
    
  </tr>
  <tr height="30">      
    <td colspan="4" align="right" >
        	<%
    	String sessionId = (String)session.getAttribute("sessionId");
    	if(sessionId != null){
    	 if(sessionId.equals(cm.getWriter())){ %>
	  <input type="button" value="글수정" 
       onclick="document.location.href='commuUpdate.jsp?num=<%=cm.getNum()%>&pageNum=<%=pageNum%>'">
	   &nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="button" value="글삭제" 
       onclick="document.location.href='commuDelPro.jsp?num=<%=cm.getNum()%>&pageNum=<%=pageNum%>&state=0'">
	   &nbsp;&nbsp;&nbsp;&nbsp;
	   <%}
	      if(sessionId.equals("admin")){ %>
	  <input type="button" value="관리자 글삭제" 
       	onclick="document.location.href='deleteAdminPro.jsp?num=<%=cm.getNum()%>&pageNum=<%=pageNum%>'">
	   	&nbsp;&nbsp;&nbsp;&nbsp;
	   <%}
	   }%>
       <input type="button" value="글목록" 
       onclick="document.location.href='commuList.jsp?pageNum=<%=pageNum%>'">
    </td>
  </tr>
</table>  
</form> 
<br />



<center>댓글 (<%=count%>개)</center>

<%
    if (count == 0) {
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
    <td align="center">
   댓글이 없습니다.
    </td>
</table>
<%  } else {%> 

<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="20"> 
      <td align="center"  width="100" >작성자</td>
      <td align="center"  width="400" >내  용</td>
      <td align="center"  width="130" >작성일</td>
      <td align="center"  width="70" >     </td> 
    </tr>   
<%  
        for (int i = 0 ; i < cmtList.size() ; i++) {
          CommentDTO cmt = (CommentDTO)cmtList.get(i);
          
    if(cmt.getCmt_state() == 1){
%>
    <tr height="30">
    <td align="center"  width="100"><%=cmt.getCmt_writer()%></td> 	
	<td align="center"  width="400"><%=cmt.getCmt_content()%></td>
    <td align="center"  width="100"><%= sdf.format(cmt.getCmt_date())%></td> 					
    <%
    if(sessionId != null){
    	if(sessionId.equals(cmt.getCmt_writer())){ %>
	  <td align = "center"><input type="button" value="삭제" 
       onclick="document.location.href='cmtDelPro.jsp?num=<%=cm.getNum()%>&pageNum=<%=pageNum%>&state=0&cmt_num=<%=cmt.getCmt_num()%>'"></td>
       </tr>
	<%		}
    	}
     }
}%>
</table>
<%}

	if(sessionId != null){ %>
<form method="post" name="writeform" action="cmtWritePro.jsp" onsubmit="return writeSave()">
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30"> 

      <td align="center"  width="100" >작성자</td>
      <td align="center"  width="650" >내   용</td>
    </tr>
    <tr>
    	<td align="center"><%=sessionId %><input type="hidden" name="cmt_writer" value="<%=sessionId %>"></td>
    	<td width="330"><textarea placeholder="댓글을 입력하세요." name="cmt_content"></textarea></td>
	</tr>
	<tr>
		<input type="hidden" name="num" value="<%=num %>">
		<input type="hidden" name="pageNum" value="<%=pageNum %>">
		<td colspan=2 align="center"><input type="submit" value="등록">
	</tr>
	</table>
	</form>
<%}else{ %>

    	<br />회원만 댓글쓰기가 가능합니다.
<%}
   }else{%>
	   <meta http-equiv="Refresh" content="0;url=/myShop/community/commuList.jsp">
   <% }%>
	
</body>
</html>      

<br /><br /><br /><br /><br />
<%@ include file="/include/bottom.jsp" %> <!--하단 -->