<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp"%>
<style type="text/css">
	.popup {position: absolute;}
	.back { background-color: gray; opacity: 0.5; width: 100%; height: 300%; overflow: hidden; z-index: 1101;}
	.front { z-index: 1110; opacity:1; boarder:1px; margin: auto;}
	.show { position: relative; max-width: 1200px; max-height: 800px; overflow: auto;}
</style>

<form role="form">
	<input type="hidden" name="replycnt" value="${boardVO.replycnt}">
	<input type="hidden" name="bno" value="${boardVO.bno}">
	<input type="hidden" name="page" value="${cri.page}">
	<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
	<input type="hidden" name="searchType" value="${cri.searchType}">
	<input type="hidden" name="keyword" value="${cri.keyword}">
</form>

<!-- ------------------ 게시글 -------------------------- -->
<div class="box-body">
	<div class="form-group">
		<label for="exampleInputEmail1">Title ${boardVO.replycnt} </label> <input type="text"
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


<!-- 파일 조회 -->
	<div class="popup back" style="display: none;"></div>
	<div id="popup_front" class="popup front" style="display: none;">
		<img id="popup_img">
	</div>
	<ul class="mailbox-attachments clearfix uploadedListAttach" >
		<script id="templateAttach" type="text/x-handlebars-template">
			<li data-src='{{fullName}}'>
				<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
				<div class="mailbox-attachment-info">
					<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
					</span>
				</div>
			</li>
		</script>
	</ul>
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
			<li class="time-label" id="repliesDiv">
				<span class="bg-green">
					Replies List
					<small id="replycntSmall2">[ ${boardVO.replycnt} ]</small>
				</span>
			</li>
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
								data-toggle="modal" data-target="#modalModify">Modify</a>
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
<div id="modalModify" class="modal modal-primary fade" role="dialog">
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

<!-- handlebars -->
<script	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.js"></script>
<!-- readPage.js -->
<script src="/resources/js/readPage.js"></script>
<script src="/resources/js/upload.js"></script>
<script>
var bno = $('input[name="bno"]').val();
var template = Handlebars.compile($("#templateAttach").html());

$.getJSON("/sboard/getAttach/" + bno, function(list){
	$(list).each(function(){
		var fileInfo = getFileInfo(this);
		var html = template(fileInfo);
		$(".uploadedListAttach").append(html);
	});
});
// 이미지 파일출려 <> 파일은 그대로 다운로드
$(".uploadedListAttach").on("click", ".mailbox-attachment-info a", function(event){
	var fileLink = $(this).attr("href");
	
	if(checkImageType(fileLink)){
		event.preventDefault();
		var imgTag = $("#popup_img");
		imgTag.attr("src", fileLink);
		
		console.log("imgTag.attr(src) : " + imgTag.attr("src"));
		
		$(".popup").show('slow');
		imgTag.addClass("show");
	}
});
// 클릭시 닫힘
$("#popup_img").on("click", function(){
	$(".popup").hide('slow');
});

$("#btnRemove").on("click", function() { // Remove
	var replyCnt = $('input[name="replycnt"]').val();
	
	console.log(replyCnt);
	if(replyCnt > 0){
		alert("댓글이 달린 게시물을 삭제할 수 없습니다.");
		return;
	}
	
	var arr = [];
	$(".uploadedListAttach").each(function(index){
		arr.push($(this).attr("data-src"));
	});
	
	if(arr.length > 0){
		$.post("/deleteAllFiles", {files:arr}, function(){
			
		});
	}
	
	formObj.attr("method", "post");
	formObj.attr("action", "/sboard/remove");
	formObj.submit();
});


</script>

<%@ include file="../include/footer.jsp"%>