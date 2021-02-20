<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<style>
textarea {
        width: 100%;
        height: 100px;
      }
      </style>
<center> <b>댓글쓰기</b> <br>

<form method="post" name="writeform" action="cmtWritePro.jsp" onsubmit="return writeSave()">
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30"> 
      <td align="center"  width="100" >작성자</td>
      <td align="center"  width="250" >내   용</td>
    </tr>
    <tr>
    	<td align="center">아이디<input type="hidden" name="writer" ></td>
    	<td width="330"><textarea placeholder="댓글을 입력하세요."></textarea></td>
	</tr>
	<tr>
		<td colspan=2 align="center"><input type="submit" value=" 글쓰기 "> 
		<input type="reset" value=" 다시작성 ">
	</tr>
	</table>
	</form>