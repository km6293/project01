<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "myshop.community.CommunityDAO" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="community" scope="page" class="myshop.community.CommunityDTO" />
<jsp:setProperty name="community" property="*"/>
 
<%
	community.setReg_date(new Timestamp(System.currentTimeMillis()) );
	CommunityDAO dao = CommunityDAO.getInstance();
    dao.insertCommu(community);

    response.sendRedirect("commuList.jsp");

%>
