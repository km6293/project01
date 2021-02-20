<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>

<%
	String email = request.getParameter("email");	
	String idx = request.getParameter("idx");	
%>

<script language="JavaScript">
    
    function checkIt() {
        var opinput = eval("document.opinput");
        
        if(!opinput.subject.value) {
            alert("제목를 입력하세요");
            return false;
        }
        
        if(!opinput.content.value ) {
            alert("내용을 입력하세요");
            return false;
        }
    }
</script>

<center>
<body>
    <div>
        <form action="mailPro.jsp" method="post" name="opinput" onSubmit="return 
        checkIt()">
            <table>
                <tr><th colspan="2">JSP 메일 보내기</th></tr>
                <tr><td> </td><td><input type="hidden" name="idx" value="<%=idx %>"/></td></tr>
                <tr><td> </td><td><input type="hidden" name="from" value="kimheec2000@naver.com"/></td></tr>
                <tr><td>받는사람</td><td><%=email %><input type="hidden" name="to" value="<%=email %>" /></td></tr>
                <tr><td>제목</td><td><input type="text" name="subject" /></td></tr>
                <tr><td>내용</td><td><textarea name="content" style="width:170px; height:200px;"></textarea></td></tr>
                <tr>
                <td colspan="2" style="text-align:right;">
                <button onclick="window.location='/myShop/manager/questionDetails.jsp'" >돌아가기</button>
                <input type="submit" value="Transmission"/>
                </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</center>
</html>