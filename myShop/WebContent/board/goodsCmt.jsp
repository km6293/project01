<%@page import="myshop.goodscmt.CmtDTO"%>
<%@page import="myshop.goodscmt.CmtDAO"%>
<%@page import="myshop.goods.MyShopDTO"%>
<%@page import="myshop.goods.MyShopDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Timestamp"%>

<%
	String sessionId = (String) session.getAttribute("sessionId");
	String goods_code = request.getParameter("goods_code");
	int code = 0;
	code = Integer.parseInt(goods_code);

	MyShopDAO dao = MyShopDAO.getInstance();
	MyShopDTO dto = dao.detailGoods(code);

	if (dto != null) {
%>

<%
	int pageSize = 5;

		String cmtPageNum = request.getParameter("cmtPageNum");
		if (cmtPageNum == null) {
			cmtPageNum = "1";
		}

		int currentPage = Integer.parseInt(cmtPageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		int count = 0;
		int number = 0;

		List<CmtDTO> cmtList = null;
		CmtDAO cmt = CmtDAO.getInstance();

		cmtList = cmt.getList(code);
		count = cmtList.size();

		if (count > 0) {
			cmtList = cmt.getList(code, startRow, endRow);
		}
		int iNum = (currentPage - 1) * pageSize;
		number = count - (currentPage - 1) * pageSize;
%>


<%--goodsCmt 추가--%>

<center>
	<%=dto.getGoods_name()%>
	상품에 대한
	<%=count%>
	개의 의견이 있어요!
	<%
		if (sessionId != null) {
	%>
<script language="javascript">
	function formCheck(frm) {
    if (frm.content.value == "") {
        alert("내용을 입력해 주세요!");
        frm.content.focus();
        return false;
    }
}
</script>
				
	<form method="post" action="goodsCmtPro.jsp" onsubmit="return formCheck(this)">
		<input type="hidden" name="goods_code" value="<%=code%>" />
		<table style="align-content: center; width: 40%;" border="1">
			<tr>
				<td rowspan="2" style="width: 10%;" ><%=sessionId%><input
					type="hidden" name="writer" value="<%=sessionId%>"></td>
				<td rowspan="2" style="width: 70%"><input type="text"
					name="content" style="width: 100%; height: 20px"></td>	
				<td rowspan="2" style="width: 20%"><input type="submit"
					VALUE="입력 "></td>					
			</tr>
		</table>

		<%
			}
		%>
	</form>

	<br>

	<%----%>
	<%
		if (cmtList != null) {
				//for(CmtDTO cmtt : cmtList){ 
				for (int i = 0; i < cmtList.size(); ++i) {
					CmtDTO cmtt = cmtList.get(i);
	%>
	<table style="align-content: center; width: 40%;" border="1">
		<tr>
			<td><%=number--%>
			<td rowspan="2" style="width: 60%"><%=cmtt.getContent()%></td>
			<td><%=cmtt.getReg_date()%></td>
		</tr>
		<tr>
			<td><%=cmtt.getWriter()%></td>
			<%
				if (sessionId != null && sessionId.equals(cmtt.getWriter())) {
			%>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;<a
				href="goodsCmtDel.jsp?num=<%=cmtt.getNum()%>&goods_code=<%=goods_code%>">삭제</a>
			</td>
			<%
				}
			%>
		</tr>
	</table>
	<br>
	<%
		}
			}
	%>

	<%
		if (count > 0) {
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);

				int startPage = (int) (currentPage / 10) * 10 + 1;
				int pageBlock = 10;
				int endPage = startPage + pageBlock - 1;
				if (endPage > pageCount)
					endPage = pageCount;

				if (startPage > 10) {
	%>
	<a
		href="goodsDetail.jsp?cmtPageNum=<%=startPage - 10%>&goods_code=<%=goods_code%>">[이전]</a>
	<%
		}
				for (int i = startPage; i <= endPage; i++) {
	%>
	<a href="goodsDetail.jsp?cmtPageNum=<%=i%>&goods_code=<%=goods_code%>">[<%=i%>]
	</a>
	<%
		}
				if (endPage < pageCount) {
	%>
	<a
		href="=goodsDetail.jsp?cmtPageNum=<%=startPage + 10%>&goods_code=<%=goods_code%>">[다음]</a>

	<%
		}
			}
		}
	%>