<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>ADMIN PAGE</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="../res/adminNavSub.js"></script>
<%@ include file="../common/scriptImport.jsp"%>
<script>
function delReply() {
	$('.replyDel').click(function(e) {
		let replyNo = $(this).attr('id').trim();
		
		swal({
			title: '',
			text: '댓글을 삭제하시겠습니까?',
			type: 'warning',
			showCancelButton: true,
			confirmButtonText: '확인',
			cancelButtonText: '취소',
			closeOnConfirm: false
		},
		function(isConfirm) {
			if(isConfirm) {
				$.ajax({
					url: '../removeReply',
					data: {replyNum: replyNo},
					success: () => {
						location.reload();
					}
				});
			}	
		});
	});
};

function readReplyCnt() {
	let replyNum = $('.replyBox').length;
	$('h4').eq(1).children().html('댓글 &nbsp;<font>' 
			+ replyNum + '</font>');
}

function validate() {
	// 이미지가 없는 글
	$('img').each(function() { 
		if (isFinite($(this).attr('src').split('/').pop()))
			$(this).remove();
	})
	
	// 페이징 번호
    let params = {}; 
    window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str, key, value) { params[key] = value; });
    
    $('#reportList').click(() => {
    	location.href = "../reportListView?page=" + ${page};
    })
    
    // 존재하지 않는 페이지 번호
    if (!$('.reportInfo').eq(0).text())
    	location.href = "../reportListView?isData=false";
}

$(delReply);
$(readReplyCnt);
$(validate);
</script>
<style>
	* {margin: 0;padding: 0;box-sizing: border-box;}
	
	body {background: #f3f5f9;}
	
	#leftNav {display: flex;position: relative;}
	#leftNav .main_content {width: 100%;margin-left: 200px;}
	#leftNav .main_content .header {padding: 11px;background: #fff;color: #717171;border-bottom: 1px solid #e0e4e8;}
	#leftNav .main_content .header .border {font-size: 19px;}
	#leftNav .main_content .header #topButton {text-decoration: none;margin-top: 4px;margin-right: 20px;float: right;}
	#leftNav .main_content .header #topButton a {text-decoration: none;}
	#leftNav .main_content .info {margin: 60px;color: #717171;}
	
	#content {float: left;margin-left: 10px;width: 400px;display: inline;}
	.reportInfo {margin-right: 15px;}
	.reportContent {margin-bottom: 150px;}
	.list {background: #4b4276;color: #fff;float: right;}
	.replyDel {float: right;margin-top: 3px;}
	.replyBox {padding: 6px 10px 5px 10px;}
	.replyContent {margin-top: 3px;}
	.marker {background-color: yellow;}
</style>
</head>

<body>
	<div class='wrapper' id='leftNav'>
		<div class='sidebar' id='sidebar'>
			<%@ include file="../common/nav.jsp"%>
		</div>
		<div class='main_content'>
			<div class='header'>
				<strong>&nbsp;&nbsp;ADMINSTRATOR</strong>
				<div id='topButton'>
					<a href='<c:url value='../../common/logoRegist'/>'>로고관리</a>&nbsp;|&nbsp;
					<a href='<c:url value='../../common/bannerRegist'/>'>배너관리</a>&nbsp;|&nbsp;
					<a href='<c:url value='/'/>'>홈페이지 돌아가기</a>&nbsp;|&nbsp; <a
						href='<c:url value='../../../user/logout'/>'>로그아웃</a>
				</div>
			</div>
			<div class='info'>
				<div class='content'>
					<h3>
						<span class='glyphicon glyphicon-bullhorn'></span> <strong>
							신고 게시판 관리 > 상세</strong>
					</h3>
					<hr style='border: 1px solid #a0a0a0;'>
					<h4>
						<strong>${report.title}</strong>
					</h4>
					<strong class='reportInfo'>${report.userId}</strong> <span
						class='glyphicon glyphicon-eye-open reportInfo'>&nbsp;${report.viewCount}</span>
					<span class='glyphicon glyphicon-time reportInfo'>&nbsp;${report.regDate}</span>
				</div>
				<hr>

				<img src='<c:url value="/attach/report/${report.attachName}"/>' /><br>
				<br>
				<div class='reportContent'>${report.content}</div>
				<button id='reportList' class='btn list'>목록</button><br>
				<br>
				<hr>

				<h4>
					<strong>댓글</strong>
				</h4>
				<br>
				<c:forEach var='reply' items='${replies}'>
					<div style='background-color: #eeeeee;'>
						<div class='replyBox'>
							<span><strong>${reply.userId}</strong>&nbsp;&nbsp;${reply.regDate}</span>
							<button id='${reply.replyNum}' type='button'
								class='btn btn-danger replyDel'>삭제</button>
							<div class='replyContent'>
								${reply.content}<br>&nbsp;
							</div>
						</div>
					</div>
					<br>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>