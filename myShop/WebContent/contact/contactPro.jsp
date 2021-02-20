<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
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
		ContactDTO cdto = new ContactDTO();
		request.setCharacterEncoding("UTF-8"); 
		
		String save = application.getRealPath("/imgsave/contactimg/");
		int size = 1024*1024*10; // 10mb
		String enc = "UTF-8";
		DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
		MultipartRequest mr = new MultipartRequest(request,save,size,enc,dp);

		//파라미터 받아서 dto에 입력
		cdto.setGoods_code(Integer.parseInt(mr.getParameter("goods_code")));
		cdto.setWriter(mr.getParameter("writer"));
		cdto.setEmail(mr.getParameter("email"));
		cdto.setGoods_brand(mr.getParameter("goods_brand"));
		cdto.setSubject(mr.getParameter("subject"));
		cdto.setContent(mr.getParameter("content"));
		if(mr.getParameter("filename")!=null){
			cdto.setFilename(mr.getParameter("filename"));
		}
 		cdto.setReg_date(new Timestamp(System.currentTimeMillis()));		//현재시각으로 작성시각 입력
 		
		//DAO 객체 불러오기
    	ContactDAO cdao = ContactDAO.getInstance();
		//문의입력 메소드 호출
    	cdao.insertContact(cdto);
		//문의내역으로 리디렉트
		%>
<script>
	alert("등록되었습니다.");
	window.location="/myShop/contact/contactList.jsp";
</script>
<%
	}catch(Exception ex){
		ex.printStackTrace();
	}
%>