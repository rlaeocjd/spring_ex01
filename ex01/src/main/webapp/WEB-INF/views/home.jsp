<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ page session="false" %> --%>
    
<%-- <%@ include file="include/header.jsp" %> --%>

	<!-- Main content -->
	<section class="content">
		<div class="row">
			<!--  left column -->
			<div class="col-md-12">
				<!-- general form elements -->
				<div class="box">
					<div class="box-header with-border">
						<h3 class="box-title">Home Page</h3>
					</div>
					<!-- <a href="/board/listAll">listAll</a></p> -->
					<a href="/board/listCri">listCri</a></p>
					<a href="/board/listPage">listPage</a></p>
					<a href="/sboard/list">sboard/list</a></p>
					<a href="/user/login">/user/login</a></p>
				</div>
			</div><!-- /.col (left) -->
		</div><!-- /.row -->
	</section><!-- /.content -->
	
	<h2>${result}</h2>
	
<%-- <%@ include file="include/footer.jsp" %> --%>