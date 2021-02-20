<%@page import="java.net.InetAddress"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈페이지 운영자 문의</title>
</head>
<body>
<%@ include file="/include/top.jsp"%>


<script language="JavaScript">
    
    function checkIt() {
        var opinput = eval("document.opinput");
        
        if(!opinput.op_id.value) {
            alert("사용자 / 업체 명를 입력하세요");
            return false;
        }
        
        if(!opinput.op_email.value ) {
            alert("이메일을 입력하세요");
            return false;
        }
        if(!opinput.op_phone.value ) {
            alert("전화번호을 입력하세요");
            return false;
        }
        if(!opinput.op_title.value ) {
            alert("제목을 입력하세요");
            return false;
        }
        if(!opinput.op_content.value ) {
            alert("내용을 입력하세요");
            return false;
        }
    }
</script>
<%
String sessionID = "null";
if(session.getAttribute("sessionId") !=null){
sessionID = (String)session.getAttribute("sessionId");
}
if(sessionID.equals("null")){
	sessionID="비회원";
}
	%>
<div style="align: centser;">
	<form action="opBoardPro.jsp" name="opinput" method="post" onSubmit="return checkIt()" style="width:300px; left:40%; right:45%;position: absolute; background-color: #CCFFFF;">
			<input type="hidden" value="1" name="op_answer">
			<input type="hidden" value="<%= InetAddress.getLocalHost() %>" name="op_ip">
			
		<table >
			<tr>
				<td style="text-align: right;">사용자 / 업체 명</td>
				<td><input type="text" name="op_id" size="5" value="<%=sessionID%>" readonly></td>
			</tr>
			<tr>
				<td style="text-align: right;">이메일</td>
				<td><input type="email" name="op_email"></td>
			</tr>
			<tr>
				<td style="text-align: right;">전화번호</td>
				<td><input type="text" name="op_phone"></td>
			</tr>
			<tr>
				<td style="text-align: right;">제목</td>
				<td><input type="text" name="op_title"><br /></td>
			</tr>
			<tr>
				<td style="text-align: right;">내용</td>
				<td><input type="text" style="height: 200px;" name="op_content"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" 	value="문의하기"style="width: 100%"></td>
				<td></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>