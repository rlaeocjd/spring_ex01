/**
 * readPage.jsp 게시글, 댓글 조회창 : 페이징, handlebars
 */

// 전역 변수
var formObj = null; // 게시판 : hidden 요소 저장
var bno = 0; // 댓글이 걸려있는 본글의 번호
var replyPage = 0; // 사용자가 보고있는 댓글 페이징

$(document).ready(function() {
	init();
	event();
});

function init() {
	formObj = $("form[role='form']");
	bno = $('input[name="bno"]').val();
	replyPage = 1;
}

function event() {
	boardEvent();
	replyEvent();
}

/* 게시글 관련 이벤트 */
function boardEvent() {
	$("#btnModify").on("click", function() { // Modify
		formObj.attr("method", "get");
		formObj.attr("action", "/sboard/modifyPage");
		formObj.submit();
	});
	$("#btnRemove").on("click", function() { // Remove
		formObj.attr("method", "post");
		formObj.attr("action", "/sboard/remove");
		formObj.submit();
	});
	$("#btnList").on("click", function() { // List
		formObj.attr("method", "get");
		formObj.attr("action", "/sboard/list");
		formObj.submit();
	});
}

/* 댓글 관련 이벤트 */
function replyEvent() {
	// 댓글 등록, 페이징 1로 이동
	$("#replyAddBtn").on("click", function() {
		var replyerObj = $("#newReplyWriter");
		var replytextObj = $("#newReplyText");
		var replyer = replyerObj.val();
		var replytext = replytextObj.val();

		$.ajax({ // json 형태로 자료를 보내기 위해 사용.
			type : 'post', // rest 타입
			url : '/replies/',
			headers : { // 몇몇 지원안하는 브라우저를 위해 추가
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : 'text',
			data : JSON.stringify({ // 보낼 데이터
				bno : bno,
				replyer : replyer,
				replytext : replytext
			}),
			success : function(result) {
				if (result == 'SUCCESS') {
//					alert("등록 되었습니다.");
					replyPage = 1;
					getPage("/replies/" + bno + "/" + replyPage);
					replyerObj.val("");
					replytextObj.val("");
				}
			}
		});
	});

	// 덧글 불러오기, 활성화
	$("#repliesDiv").on("click", function() {
		if ($(".timeline li").size() > 1) {
			return;
		}
		getPage("/replies/" + bno + "/1");
	});

	// 페이징 버튼 클릭시 이동
	$(".pagination").on("click", "li a", function(event) {
		event.preventDefault();
		replyPage = $(this).attr("href");
		getPage("/replies/" + bno + "/" + replyPage);
	});
	
	// 클릭한 요소안의 데이터를 modal에 출력
	$(".timeline").on("click", ".replyLi", function(event){
		var reply = $(this);
		
		$("#replytext").val(reply.find('.timeline-body').text());
		$(".modal-title").html(reply.attr("data-rno"));
	});
	// Modal 에서의 수정버튼
	$("#replyModBtn").on("click", function(){
		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();
		
		$.ajax({
			type:'put',
			url:'/replies/'+rno,
			headers : { // 몇몇 지원안하는 브라우저를 위해 추가
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "PUT"},
			data:JSON.stringify({replytext:replytext}),
			dataType:'text',
			success:function(result){
				console.log("result: " + result);
				if(result == 'SUCCESS'){
					alert("수정 되었습니다.");
					getPage("/replies/" + bno + "/" + replyPage);
				}
			}
		});
	})
	
	// Modal 에서의 삭제버튼
	$("#replyDelBtn").on("click", function(){
		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();
		
		$.ajax({
			type:'delete',
			url:'/replies/'+rno,
			headers : { // 몇몇 지원안하는 브라우저를 위해 추가
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "DELETE"},
			data:JSON.stringify({replytext:replytext}),
			dataType:'text',
			success:function(result){
				console.log("result: " + result);
				if(result == 'SUCCESS'){
					alert("삭제 되었습니다.");
					getPage("/replies/" + bno + "/" + replyPage);
				}
			}
		});
	})
}

// 덧글과 페이징 출력
function getPage(pageInfo) {
	$.getJSON(pageInfo, function(data) {
		printData(data.list, $("#repliesDiv"), $("#template"));
		printPaging(data.pageMaker, $(".pagination"));
	});
}
// Handlebars를 이용하여 덧글 출력
var printData = function(replyArr, target, templateObject) {
	var template = Handlebars.compile(templateObject.html());

	var html = template(replyArr);
	$(".replyLi").remove();
	target.after(html);
}
// {{prettifyDate regdate}} 덧글의 시간 부분 해당
Handlebars.registerHelper("prettifyDate", function(timeValue) {
	var dateObj = new Date(timeValue);
	var year = dateObj.getFullYear();
	var month = dateObj.getMonth() + 1;
	var date = dateObj.getDate();
	return year + "/" + month + "/" + date;
});
// 페이징 버튼 출력
function printPaging(pageMaker, target) {
	var str = "";

	if (pageMaker.prev) {
		str += "<li><a href='" + (pageMaker.startPage - 1) + "'> << </a></li>";
	}

	for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
		var strClass = pageMaker.cri.page == i ? 'class=active' : '';
		str += "<li " + strClass + "><a href='" + i + "'>" + i + "</a></li>";
	}

	if (pageMaker.next) {
		str += "<li><a href='" + (pageMaker.endPage + 1) + "'> >> </a></li>";
	}
	target.html(str);
};

