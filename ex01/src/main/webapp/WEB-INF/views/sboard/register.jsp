<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@	page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/header.jsp" %>
<style type="text/css">
	.fileDrop {
		width: 70%;
		height: 140px;
		border: 1px dotted blue;
	}
	
/* 	small {
		margin-left: 3px;
		font-weight: bold;
		color: gray; 
	} */
</style>

<form role="form" method="post" id="registerForm">
	<div class="box-body">
		<div class="form-group">
			<label for="exampleInputEmail1">Title</label>
			<input type="text" name="title" class="form-control" placeholder="Enter Title">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Content</label>
			<textarea rows="3" class="form-control" name="content" placeholder="Enter ....."></textarea>
		</div>
		<div class="form-group">
			<label for="exampleInputEmail1">Writer</label>
			<input type="text" name="writer" class="form-control"
					value="${login.uid}" readonly="readonly">
		</div>
		<div class="form-group">
			<label for="exampleInputEmail1">File DROP Here</label>
			<div class="fileDrop"></div>
		</div>
	</div>
	<!--  /.box-body -->
		
	<div class="box-footer">
		<div>
			<hr>
		</div>
		
		<ul class="mailbox-attachments clearfix uploadedList">
	<script id="template" type="text/x-handlebars-template">
	<li>
		<span class="mailbox-attachment-icon has-img">
			<img src="{{imgsrc}}" alt="Attachment">
		</span>
		<div class="mailbox-attachment-info">
			<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
			<a href="{{fullName}}" class="btn btn-default btn-xs pull-right delbtn">
				<i class="fa -fa-fw fa-remove"></i>
			</a>
			</span>
		</div>
	</li>
	</script>
		</ul>
	
		<button type="submit" class="btn btn-primary">Submit</button>
	</div>
</form>


<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.js"></script>
<script src="/resources/js/upload.js" type="text/javascript"></script>
<script>
	var template = Handlebars.compile($("#template").html());
	
	$(".fileDrop").on("dragenter dragover", function(event){
		event.preventDefault();
	});
	
	$(".fileDrop").on("drop", function(event){
		event.preventDefault();
		
		var files = event.originalEvent.dataTransfer.files;
		var file = files[0];
		//console.log(file);
		var formData = new FormData();
		formData.append("file", file);
		
		$.ajax({
			url: '/uploadAjax',
			data: formData,
			dataType: 'text',
			processData: false,
			contentType: false,
			type: 'POST',
			success: function(data){
				var fileInfo = getFileInfo(data);
				
				var html = template(fileInfo);
				
				$(".uploadedList").append(html);
			}
		});
	});
	
	$("#registerForm").submit(function(event){
		event.preventDefault();
		
		var that = $(this);
		
		var str = "";
		
		$(".uploadedList .delbtn").each(function(index){
			str += "<input type='hidden' name='files[" + index +"]' value='" + $(this).attr("href") +"'>";
		});
		that.append(str);
		that.get(0).submit();
	});
</script>
<%@ include file="../include/footer.jsp" %>