<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="myshop.contact.ContactDAO" %>
<%@ page import="myshop.contact.ContactDTO" %>

     <h1>contactPro 페이지..!!</h1>
<%
	request.setCharacterEncoding("UTF-8");

	//세션 획득
	String userId = (String)session.getAttribute("sessionId");

	//로그인되어 있지 않으면 loginForm.jsp파일로 리디렉트합니다.
	if(userId==null){response.sendRedirect("loginForm.jsp");}
	try{
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		ContactDTO cdto = new ContactDTO();

		//파라미터 받아서 dto에 입력
		cdto.setNum(num);
		cdto.setEmail(request.getParameter("email"));
		cdto.setSubject(request.getParameter("subject"));
		cdto.setContent(request.getParameter("content"));
		
		//DAO 객체 불러오기
    	ContactDAO cdao = ContactDAO.getInstance();
		//문의입력 메소드 호출
    	cdao.updateContact(cdto);
		//문의내역으로 리디렉트
		%>
<script>
	alert("수정되었습니다.");
	window.location="/myShop/contact/contactDetail.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
</script>
<%
	}catch(Exception ex){
		ex.printStackTrace();
	}
%>