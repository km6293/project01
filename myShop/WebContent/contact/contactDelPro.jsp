<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="myshop.contact.ContactDAO" %>
<%
int num = Integer.parseInt(request.getParameter("num"));
ContactDAO cdao = ContactDAO.getInstance();
cdao.deleteContact(num);
%>
<script>
alert("삭제되었습니다.");
window.location="/myShop/contact/contactList.jsp";
</script>