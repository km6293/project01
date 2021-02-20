<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>약관동의</title>
<link rel="stylesheet" type="text/css" href="/myShop/css/join.css" />
<script type="text/javascript">
    function CheckForm(Join){
        //체크박스 체크여부 확인 [하나]
        var chk1=document.frmJoin.a.checked;
        var chk2=document.frmJoin.b.checked;
        if(!chk1){
            alert('서비스약관에 동의해 주세요');
            return false;
        } 
        if(!chk2) {
            alert('개인정보 수집에 동의해 주세요');
            return false;
        }
    }
 </script>


</head>
<body>
<div style="margin-top:10px;">
<jsp:include page="/include/top.jsp"/> <!-- 상단 -->
</div>
<!-- 그림페이지 -->

<!-- 메인시작 -->

<div id="Jmainframe">
<!-- 아이디 입력공간 -->

<div id="ser1">회원가입 이용약관</div><br>
<hr  style="margin:3% 10%;">
<!-- 이용약관 시작 -->



<div id="ser2"><label for="ser2_1"><span id="t1"></span></label></div><br><br>
<div id="ser3">
<form name="frmJoin" action="/myShop/login/insertForm.jsp" onSubmit="return CheckForm(this)">
<input type="checkbox" id="ser3_1" name="a">
<label for="ser3_1">myshop 서비스 약관동의 <span id="t2">(필수)</span></label></div> <br><br>
<div id ="ser3_1_1"><%@include file="./pieces_txt/join_txt1.jsp" %></div><br>
<div id="ser4"><input type="checkbox" id="ser4_1" name="b" >
<label for="ser4_1">개인정보 수집 및 이용동의<span id="t2">(필수)</span></label></div> <br><br>
<div id ="ser3_1_2"><%@include file="./pieces_txt/join_txt2.jsp" %></div><br>
<div id="ser5"><input type="checkbox" id="ser5_1"><label for="ser5_1">위치기반서비스 이용약관 동의안내<span id="t2">(선택)</span></label></div> <br><br>
<div id ="ser3_1_3"><%@include file="./pieces_txt/join_txt3.jsp" %></div><br>
<div id="ser6"><label for="ser6_1">※ 선택사항에 동의하지 않으셔도 서비스 가입 및 이용이 가능하나,&nbsp; 동의하지 않을 경우 제공 가능한 관련 편의 사항 등 (주변매장찾기 , 적립금, 기타 각종 혜택 등)이 제한될 수 있습니다.</label></div> <br><br><hr style="margin:2% 10%;">
<div id="ser7"><input type="submit"id="ser7_1" value="회원가입"></div>
</form><br><br><br><br></div><br>
</body>

</html>