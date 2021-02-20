<%@page import="myshop.notice.NoticeDAO"%>
<%@page import="myshop.notice.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>

<%
	request.setCharacterEncoding("UTF-8");
	String save = request.getRealPath("/imgsave/comimg"); 
	int size = 1024*1024*100;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, save, size, enc, dp);
	
	String type = mr.getContentType("noticeFile");
	
	NoticeDTO dto = new NoticeDTO();
	
	dto.setNoti_num(Integer.parseInt(mr.getParameter("num")));
	dto.setNoti_writer(mr.getParameter("writer")); 
	dto.setNoti_subject(mr.getParameter("subject"));  
	dto.setNoti_content(mr.getParameter("content"));  
	dto.setNoti_file(mr.getFilesystemName("noticeFile"));
	dto.setNoti_date(new Timestamp(System.currentTimeMillis()));

	NoticeDAO dao = NoticeDAO.getInstance();
	dao.insertNotice(dto);
%>
	<script>
		alert("등록되었습니다.");
		window.location = "noticeList.jsp";
	</script>


