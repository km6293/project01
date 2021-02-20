<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String goods_brand = (String)session.getAttribute("sessionId");
   if(goods_brand == null) {
%>      <script>
      alert("로그인 후 글쓰기 가능합니다");
      window.loaction='/web/user/login.jsp';
      </script>
   <%}%>
   
   <script language="javascript">

   function formCheck(frm) {
if (frm.file1.value == "") {
	 alert("상품 이미지를 등록해주세요.");
     frm.file1.focus();
     return false;
   }   
if (frm.goods_name.value == "") {
      alert("상품명을 등록해주세요.");
      frm.goods_name.focus();
       return false;
   }
if (frm.goods_price.value == "") {
        alert("상품의 가격을 등록해주세요.");
        frm.goods_price.focus();
        return false;
    }
 if (frm.goods_delivery.value == "") {
        alert("배송비를 입력해주세요.");
        frm.goods_delivery.focus();
        return false;
    }
 if (frm.goods_count.value == "") {
         alert("상품 수량을 등록해주세요.");
         frm.goods_count.focus();
         return false;
    }
 if (frm.goods_msg.value == "") {
     alert("상품 상세설명을 등록해주세요.");
     frm.goods_msg.focus();
     return false;
     }
   }
</script>  

  <center>
 
<title>상품등록</title>

<link href="style.css" rel="stylesheet" type="text/css">

<h2>상품등록</h2>

   <form action="goodsPro.jsp" method="post" onsubmit="return formCheck(this)" enctype="multipart/form-data">
   		<div>
      		<input type=file name='file1' style='display: none;'>
      		<input type='hidden' name='file2' id='file2'> 
      		<img src='/myShop/dev_img/image.jpg' border='0' onclick='document.all.file1.click(); document.all.file2.value=document.all.file1.value'></br>
   		</div>
   		   
      	<div>
<!--     상품코드   <input type="text" size="50"  name="goods_code" readonly></div> -->
<!--       제조사/브랜드  --><input type="hidden" name="goods_brand" value="<%=goods_brand%>">
      상품이름 <input type="text" size="50"  name="goods_name"></br>
      가격 <input type="text" size="50"  name="goods_price"></br>
      배송비 <input type="text" size="50" name="goods_delivery"></br>
      수량 <input type="text" size="50"  name="goods_count"></br>
      상품 설명<textarea name="goods_msg" rows="13" cols="40"></textarea></br>
      
      <input type="submit" value="등록하기">
      <input type="reset" value="다시작성">
      
 </form>
  </center>