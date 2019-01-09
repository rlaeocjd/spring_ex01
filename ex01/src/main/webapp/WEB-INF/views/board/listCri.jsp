<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/header.jsp" %>
<script>
	var result = '${msg}';
	
	if(result == 'success'){
		alert("처리가 완료되었습니다.");
	}
</script>
<table class="table table-bordered">
	<tr>
		<th style="width: 10px">BNO</th>
		<th>TITLE</th>
		<th>WRITER</th>
		<th>REGDATE</th>
		<th style="width: 40px">VIEWCNT</th>
	</tr>
	<c:forEach items="${list}" var="item">
	<tr>
		<td>${item.bno}</td>
		<td><a href="/board/read?bno=${item.bno}">${item.title}</a></td>
		<td>${item.writer}</td>
		<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${item.regdate}"/></td>
		<td><span class="badge bg-red">${item.viewcnt}</span></td>
	</tr>
	</c:forEach>
</table>
<%@ include file="../include/footer.jsp" %>