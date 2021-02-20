<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="myshop.contact.ContactDAO"%>
<%@ page import="myshop.contact.ContactDTO"%>
<%@ page import="myshop.goods.GoodsDAO"%>
<%@ page import="myshop.goods.GoodsDTO"%>
<%@ page import="myshop.shopuser.UserDAO" %>
<%@ page import="myshop.shopuser.UserDTO" %>

<style>
textarea {width: 100%;height: 100px;}
</style>
<html>
<head>
<title>문의 내용</title>
</head>
<%	
	String user_id = (String)session.getAttribute("sessionId");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	if(pageNum.equals(null)){
		pageNum = "1";
	}

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	ContactDTO cdto = null;
	try {
		ContactDAO cdao = ContactDAO.getInstance();
		cdto = cdao.getContact(num);
		GoodsDAO gdao = GoodsDAO.getInstance();
		GoodsDTO gdto = gdao.goodsDetail(cdto.getGoods_code());
%>
<body>
<% 			UserDAO udao = UserDAO.getInstance();
			UserDTO udto = new UserDTO();
			udto = udao.myInfo(user_id);
			String arating = udto.getRating();
			String include = null;
			if(arating.equals("1")){
				include = "/include/top.jsp";
			}else{
				include = "/seller/seller_top.jsp";
			}
%>
<jsp:include page="<%=include %>"/>
	<center>
		<b>글내용 보기</b> <br>
			<table width="700" border="1" cellspacing="0" cellpadding="0"align="center">
				<tr height="30">
					<td align="center" width="125">작성자</td>
					<td align="center" width="125" align="center"><%=cdto.getWriter()%></td>
					<td align="center" width="125">email</td>
					<td align="center" width="125" align="center"><%=cdto.getEmail()%></td>
					<td align="center" width="125">작성일</td>
					<td align="center" width="125" align="center"><%=sdf.format(cdto.getReg_date())%></td>
				</tr>
				<tr height="30">
					<td align="center" width="125">상품이름</td>
					<td colspan="5" width="375">
					<%if(gdto!=null){%>
					<a href="/myShop/board/goodsDetail.jsp?goods_code=<%=gdto.getGoods_code()%>">
					<%=gdto.getGoods_name() %>
					</a>
					<%} %>
					</td>	
				<tr height="30">
					<td align="center" width="125">글제목</td>
					<td align="center" width="375" align="center" colspan="5"><%=cdto.getSubject()%></td>
				</tr>
				<tr height="300">
					<td align="center" width="125">글내용</td>
					<td align="left" width="375" colspan="5"><%=cdto.getContent()%></td>
				</tr>
				<tr height="30">
					<td colspan="6" align="center">
					<br/>
						<form>
<%						String sessionId = (String) session.getAttribute("sessionId");
						if (sessionId != null) {
							if (sessionId.equals(cdto.getWriter())) {
%> 								<input type="button" value="글수정"
								onclick="document.location.href='contactUpdate.jsp?num=<%=cdto.getNum()%>&pageNum=<%=pageNum%>'" />
								&nbsp;&nbsp;&nbsp;&nbsp; 
								<input type="button" value="글삭제" onclick="del()"/>
								&nbsp;&nbsp;&nbsp;&nbsp; 
<% 	
							}
							if(sessionId.equals("cdto.getGoods_brand")){
%>								<input type="button" value="답변하기"
								onclick="document.location.href='contactAnswerForm.jsp?num=<%=cdto.getNum()%>&pageNum=<%=pageNum%>'">
								&nbsp;&nbsp;&nbsp;&nbsp; 
<%							}
 							if (sessionId.equals("admin")) {
 %> 							<input type="button" value="관리자 글삭제"
								onclick="document.location.href='deleteAdminPro.jsp?num=<%=cdto.getNum()%>&pageNum=<%=pageNum%>'">
								&nbsp;&nbsp;&nbsp;&nbsp; 
<%
 							}
 						}
 %> 					<input type="button" value="글목록"
						onclick="document.location.href='contactList.jsp?pageNum=<%=pageNum%>'">
						</form>
						<br/>
					</td>
				</tr>
			</table>
		<br />	
	</center>
</body>
<%
	}catch(Exception e){}
%>
</html>
<script type="text/javascript">
<!--
function del(){
if (confirm("정말 삭제하시겠습니까??") == true){    //확인
	location.href="contactDelPro.jsp?num="+<%=cdto.getNum()%>+"&pageNum="+<%=pageNum%>;
}else{   //취소
    return;
}
}
//-->
</script>
