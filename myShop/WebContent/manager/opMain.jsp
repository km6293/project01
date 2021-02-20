<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<center>
<a href="/myShop/index.jsp">홈페이지이동</a>
<h1>운영자페이지</h1>
<input type="button" value="회사 관리"  onclick="location.href='/myShop/manager/companys.jsp'">
<input type="button" value="문의 내역 보기"  onclick="location.href='/myShop/manager/questionList.jsp'">
<input type="button" value="판매자 가입 신청 " onclick="location.href='/myShop/manager/authorizeSeller.jsp'">
</center>
</body>
</html>