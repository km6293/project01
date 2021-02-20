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
	
    String pageNum = mr.getParameter("pageNum");
    System.out.println(pageNum);
	NoticeDTO notice = new NoticeDTO();
	
	notice.setNoti_num(Integer.parseInt(mr.getParameter("num")));
	notice.setNoti_writer(mr.getParameter("writer")); 
	notice.setNoti_subject(mr.getParameter("subject"));  
	notice.setNoti_content(mr.getParameter("content"));  
	notice.setNoti_passwd(mr.getParameter("passwd"));  
	notice.setNoti_file(mr.getFilesystemName("noticeFile"));
	notice.setNoti_date(new Timestamp(System.currentTimeMillis()));

	NoticeDAO dao = NoticeDAO.getInstance();
	dao.updateNotice(notice);
%>
	<script language="JavaScript">         
        alert("수정되었습니다.");
     </script>
  <meta http-equiv="Refresh" content="0;url=noticeList.jsp?pageNum=<%=pageNum%>" >

