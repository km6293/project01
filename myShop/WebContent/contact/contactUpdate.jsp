<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="myshop.contact.ContactDAO" %>
<%@page import="myshop.contact.ContactDTO" %>
<%@page import="myshop.goods.GoodsDAO" %>
<%@page import="myshop.goods.GoodsDTO" %>

    <script language="javascript">
<!-- 
function checkFile(f){

	// files 로 해당 파일 정보 얻기.
	var file = f.files;

	// file[0].name 은 파일명 입니다.
	// 정규식으로 확장자 체크
	if(!/\.(gif|jpg|jpeg|png)$/i.test(file[0].name)) alert('gif, jpg, png 파일만 선택해 주세요.');

	// 체크를 통과했다면 종료.
	else return;

	// 체크에 걸리면 선택된  내용 취소 처리를 해야함.
	// 파일선택 폼의 내용은 스크립트로 컨트롤 할 수 없습니다.
	// 그래서 그냥 새로 폼을 새로 써주는 방식으로 초기화 합니다.
	// 이렇게 하면 간단 !?
	f.outerHTML = f.outerHTML;
}
-->
</script>
<%
	//세션 획득
    String userId = (String)session.getAttribute("sessionId");
    
	//로그인되어 있지 않으면 loginForm.jsp파일로 리디렉트합니다.
    if(userId==null){response.sendRedirect("loginForm.jsp");}
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String title = "문의수정";
	
	try{
		ContactDAO cdao = ContactDAO.getInstance();
		ContactDTO cdto = new ContactDTO();
		cdto = cdao.getContact(num);
		int goods_code = cdto.getGoods_code();
		GoodsDAO gdao = GoodsDAO.getInstance();
		GoodsDTO gdto = new GoodsDTO();
		gdto = gdao.goodsDetail(goods_code);
%>
<html>
<head>
<title><%=title %></title>
</head>
<body> 
<%@ include file="/include/top.jsp" %> 
<center><b><%=title %></b>
<br>
<table width="400" border="1" cellspacing="0" cellpadding="0" align="center">
   <tr>
    <td colspan="2" width="400" align="center">
    <%if(gdto!=null&&gdto.getGoods_name()!=null){ %>
       <%=gdto.getGoods_name()%>
    <%}else{ %>
   		 존재하지 않는 상품
    <%} %>
    </td>
  </tr>
  <form method="post" name="contactUpdate" action="contactUpdatePro.jsp?pageNum=<%=pageNum%>">
	<input type="hidden" name="num" value="<%=num %>"/>
  <tr>
    <td  width="120"  align="center" >
       제 목
    </td>
    <td  width="330">
       <input type="text" size="40" maxlength="50" name="subject" value="<%=cdto.getSubject()%>">
    </td>
  </tr>
  <tr>
   <td  align="center">
    Email
   </td>
   <td  width="330">
    <input type="text" size="40" maxlength="30" name="email"  value="<%=cdto.getEmail()%>" >
   </td>
  </tr>
  <tr>
   <td  align="center" >
      내 용
   </td>
   <td  width="330" >
    <textarea name="content" rows="13" cols="40"  value="<%=cdto.getContent()%>"></textarea> 
   </td>
  </tr>
  <tr>
   <td align="center">
  	파일
   </td>
   <td align="center"> 
  	<%=cdto.getFilename() %>
   </td>
  </tr>
  <tr>
   <td colspan=2  align="center"> 
    <input type="submit" value="수정하기" >  
    <input type="reset" value="다시작성">
  	<input type="button" value="문의내역" OnClick="window.location='contactList.jsp?pageNum=<%=pageNum%>'">
   </td>
  </tr>
</table>
<%
  }catch(Exception e){}
%>     
</form>      
</body>
</html>      