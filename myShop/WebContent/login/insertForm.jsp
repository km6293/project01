<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; UTF-8"  charset="UTF-8" >
<title>회원가입창</title>

<style>
::placeholder {
  font-size: 0.3em;
  font-weight: 400;
  opacity: 1; /* Firefox */
}

</style>

	<% request.setCharacterEncoding("UTF-8"); %>

    <script language="JavaScript">
    function checkIt() {
       
        
    for (i = 0; i < document.userinput.user_id.value.length; i++) {
        chid = document.userinput.user_id.value.charAt(i)
        if (!(chid >= '0' && chid <= '9') && !(chid >= 'a' && chid <= 'z')&&!(chid >= 'A' && chid <= 'Z')) {
            alert("아이디는 대소문자, 숫자만 입력가능합니다.")
            document.userinput.user_id.focus()
            document.userinput.user_id.select()
            return false;
        }
    }

	if (document.userinput.user_id.value.length<4 || document.userinput.user_id.value.length>12) {
	        alert("아이디를 4~12자까지 입력해주세요.")
	        document.userinput.user_id.focus()
	        document.userinput.user_id.select()
	        return false;
	    }
	
	for (i = 0; i < document.userinput.user_pw.value.length; i++) {
	       chpw = document.userinput.user_pw.value.charAt(i)
	        if (!(chpw >= '0' && chpw <= '9') && !(chpw >= 'a' && chpw <= 'z')&&!(chpw >= 'A' && chpw <= 'Z')) {
	            alert("비밀번호는 대소문자, 숫자만 입력이가능합니다.")
	            document.userinput.user_pw.focus()
	            document.userinput.user_pw.select()
	            return false;
	        }
	    }
        if(!userinput.user_id.value) {
            alert("ID를 입력하세요");
            return false;
        }
        
        if(!userinput.user_pw.value ) {
            alert("비밀번호를 입력하세요");
            return false;
        }
        if(userinput.user_pw.value != userinput.user_pw2.value)
        {
            alert("비밀번호를 동일하게 입력하세요");
            return false;
        }
       
        if(!userinput.user_name.value) {
            alert("사용자 이름을 입력하세요");
            return false;
            
        }
        if(!userinput.user_phone.value) {
            alert("핸드폰번호를 입력하세요");
            return false;
        }
      
        if(!userinput.user_birthday.value) {
            alert("생년월일을 입력하세요");
            return false;
        }
        if(!userinput.bank_num.value) {
            alert("계좌번호 입력하세요");
            return false;
        }
    }
    
    </script>

</head>
<body>
<div>
<%
String sessionId = (String) session.getAttribute("sessionId");
if (sessionId != null) {
	response.sendRedirect("myShop/member/myPage.jsp");
}
%>
<%@ include file="/include/top.jsp"%> <!-- 상단 -->


		<form action="insertPro.jsp" method="post" name="userinput" onSubmit="return checkIt()">
		<input type = "hidden" name = "join" value = "1" />
    	<input type = "hidden" name = "user_cash" value = "0" />
			<table style="width: 40; margin: auto;" border="1" >
				<caption>
					<h1>회원가입</h1>
				</caption>
				<tr>
					<td width="20%" align="right">
					<td colspan="2">
				       <label  style="background-color: #e0edf6"><a href="insertForm.jsp">&ensp;&ensp;구매자&ensp;</label>&ensp;&ensp;
				       <label><a href="insertSeller.jsp">판매자</a> </label>
				       <input type="hidden" name="rating" value="1" checked/></a></label>  
				    </td>
				</tr>
				<tr>
					<td width="40" align="right">아이디</td>
					<td><input type="text" name="user_id"  autocomplete=”off” placeholder="4글자 20글자 사이,첫글자 알파벳">
					</td>
				</tr>
				<tr>
					<td width="20%" align="right">비밀번호</td>
					<td><input type="password" name="user_pw" placeholder="4글자 20글자 사이"></td>
				</tr>
				<tr>
					<td width="20%" align="right">비밀번호 확인</td>
					<td><input type="password" name="user_pw2"></td>
				</tr>
				<tr>
					<td width="20%" align="right">성명</td>
					<td><input type="text" name="user_name" autocomplete=”off”></td>
				</tr>
				<tr>
					<td width="20%" align="right">생년월일</td>
					<td colspan="2"><input type="date" name="user_birthday"></td>
				</tr>
				<tr>
					<td width="20%" align="right">성별</td>
					<td colspan="2"><label>&ensp;&ensp;남성<input type="radio" name="user_gender" value="남성" checked /></label> 
					<label> 여성<input type="radio" name="user_gender" value="여성" /></label></td>
				</tr>
				<tr>
					<td width="20%" align="right">휴대폰번호</td>
					<td colspan="2"><input type="tel" name="user_phone"	placeholder="-제외하고 입력하세요"></td>
				</tr>
				<tr>
					<td width="20%" align="right">이메일</td>
					<td colspan="2"><input type="email" name="user_email" placeholder="이메일" autocomplete=”off”></td>
				</tr>
				
				<jsp:include page="/include/address.jsp"/>
				<tr>
					<td width="20%" align="right">주소</td>
					<td colspan="2"><input type="text" id="sample4_postcode" placeholder="우편번호" autocomplete=”off” name="user_address1">
					 <input	type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
					</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2">
					<input type="text" id="sample4_roadAddress"	placeholder="도로명주소" size="8" autocomplete=”off” name="user_address2">
					<input type="text" id="sample4_jibunAddress" placeholder="지번주소" width="30" size="8" autocomplete=”off” name="user_address3">
					<input	type="text" id="sample4_extraAddress" placeholder="참고항목" size="7" autocomplete=”off”> 
					<span id="guide"style="color: #999; display: none"> </span>
					</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2"><input type="text" id="sample4_detailAddress" placeholder="상세주소" name="user_address4"></td>
				</tr>
				<tr><!-- 주소 + 성별도넣어야하고 이메일도 넣고. -->
					<td width="20%" align="right">계좌 번호 :</td>
					<td colspan="2"><input type="text" name ="bank_num">
					<select name="bank_num2">
					<option value ="카카오"> 카카오</option>
					<option value ="농협"> 농협</option>
					<option value ="국민"> 국민</option>
					<option value ="신한"> 신한</option>
					</select>
					
					</td>
				</tr>
				<tr>
					<td colspan="2">
					 &nbsp;
					</td>			
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="회원가입" style=" width:100%;height:50px;">
					</td>			
				</tr>
			</table>
		</form>
</div>
</body>
</html>  
    