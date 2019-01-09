<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp"%>
<!-- handlebars -->
<script	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.js"></script>

<!-- ------------------ 게시글 -------------------------- -->
<form role="form">
	<input type="hidden" name="bno" value="${boardVO.bno}">
	<input type="hidden" name="page" value="${cri.page}">
	<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
	<input type="hidden" name="searchType" value="${cri.searchType}">
	<input type="hidden" name="keyword" value="${cri.keyword}">
</form>

<div class="box-body">
	<div class="form-group">
		<label for="exampleInputEmail1">Title</label> <input type="text"
			name="title" class="form-control" value="${boardVO.title}"
			readonly="readonly">
	</div>
	<div class="form-group">
		<label for="exampleInputPassword1">Content</label>
		<textarea rows="3" class="form-control" name="content"
			readonly="readonly">${boardVO.content}</textarea>
	</div>
	<div class="form-group">
		<label for="exampleInputEmail1">Writer</label> <input type="text"
			name="writer" class="form-control" value="${boardVO.writer}"
			readonly="readonly">
	</div>
</div>
<!-- /.box-body -->

<div class="box-footer">
	<button type="submit" class="btn btn-warning" id="btnModify">Modify</button>
	<button type="submit" class="btn btn-danger" id="btnRemove">REMOVE</button>
	<button type="submit" class="btn btn-primary" id="btnList">LIST</button>
</div>

<!-- ------------------ 댓글 -------------------------- -->
<div class="row">
	<div class="col-md-12">
		<!-- 댓글 등록 -->
		<div class="box box-success">
			<div class="box-header">
				<h3 class="box-title">ADD NEW REPLY</h3>
			</div>
			<div class="box-body">
				<label for="exampleInputEmail1">Writer</label>
				<input type="text" class="form-control" placeholder="USER ID" id="newReplyWriter">
				<label for="exampleInputEmail1">Reply Text</label>
				<input type="text" class="form-control" placeholder="REPLY TEXT" id="newReplyText">
			</div>
			<!-- /.box-body -->
			<div class="box-footer">
				<button type="button" class="btn btn-success" id="replyAddBtn">ADD REPLY</button>
			</div>
		</div>
		
		<!-- 댓글과 페이징 처리 -->
		<!-- The time line -->
		<ul class="timeline">
			<!--  timeline time label -->
			<li class="time-label" id="repliesDiv"><span class="bg-green">Replies List</span></li>
			<!-- Handlebar 사용 -->
			<script id="template" type="text/x-handlebars-template">
			{{#each .}}
				<li class="replyLi" data-rno={{rno}}>
					<i class="fa fa-comments bg-blue"></i>
					<div class="timeline-item">
						<span class="time">
							<i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
						</span>
						<h3 class="timeline-header"><strong>{{rno}}</strong> -{{replyer}}</h3>
						<div class="timeline-body">{{replytext}}</div>
						<div class="timeline-footer">
							<a class="btn btn-primary btn-xs"
								data-toggle="modal" data-target="#modifyModal">Modify</a>
						</div>
					</div>
				</li>
			{{/each}}
			</script>
		</ul>
		
		<div class="text-center">
			<ul id="pagination" class="pagination pagination-sm no-margin">
			
			</ul>
		</div>
	
	</div>
</div>
<!-- Modal : 덧글 수정,삭제 위한 별도의 창 -->
<div id="modifyModal" class="modal modal-primary fade" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content -->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"></h4>
			</div> <!-- 4. modal-header -->
			<div class="modal-body" data-rno>
				<p><input type="text" id="replytext" class="form-control"></p>
			</div> <!-- 5. modal-body -->
			<div class="modal-footer">
				<button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
				<button type="button" class="btn btn-danger" id="replyDelBtn">DELETE</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div> <!--  6. modal-footer -->
		</div>	<!-- 3. modal-content -->
	</div>	<!-- 2. modal-dialog -->
</div>	<!-- 1. modifyModal -->

<!-- readPage.js 따로 분류 -->
<script src="/resources/js/readPage.js"></script>

<%@ include file="../include/footer.jsp"%>