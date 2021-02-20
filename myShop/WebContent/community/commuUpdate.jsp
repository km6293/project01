<%@ page contentType = "text/html; charset=UTF-8" %>
<%@page import="myshop.community.CommunityDTO"%>
<%@page import="myshop.community.CommunityDAO"%>
<html>
<head>
<title>자유게시판</title>
<script language="JavaScript" src="script.js"></script>
</head>

<%
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");
  try{
	  CommunityDAO dao = CommunityDAO.getInstance();
	   CommunityDTO cm =  dao.updateGetCommu(num);

%>

<body>  
<center><b>글수정</b>
<br>
<form method="post" name="writeform" action="commuUpdatePro.jsp?pageNum=<%=pageNum%>" onsubmit="return writeSave()">
<table width="400" border="1" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td  width="70" align="center">이 름</td>
    <td align="left" width="330">
       <input type="text" size="10" maxlength="10" name="writer" value="<%=cm.getWriter()%>">
	   <input type="hidden" name="num" value="<%=cm.getNum()%>"></td>
  </tr>
  <tr>
    <td  width="70" align="center" >제 목</td>
    <td align="left" width="330">
       <input type="text" size="40" maxlength="50" name="subject" value="<%=cm.getSubject()%>"></td>
  </tr>
  <tr>
    <td  width="70" align="center" >내 용</td>
    <td align="left" width="330">
     <textarea name="content" rows="13" cols="40"><%=cm.getContent()%></textarea></td>
  </tr>
  <tr>      
   <td colspan=2 align="center"> 
     <input type="submit" value="글수정" >  
     <input type="reset" value="다시작성">
     <input type="button" value="목록보기" 
       onclick="document.location.href='commuList.jsp?pageNum=<%=pageNum%>'">
   </td>
 </tr>
 </table>
</form>
<%
}catch(Exception e){}%>      
      
</body>
</html>      
