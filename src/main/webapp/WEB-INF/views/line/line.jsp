<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <title>Line</title> -->

<link href="${pageContext.request.contextPath}/resources/css/instruct/line.css" rel="stylesheet" type="text/css">
<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="32x32" href="/resources/image/favicon-32x32.png">

</head>

<body>
<!-- <header> -->
	<jsp:include page="../inc/header.jsp" />
<!-- </header> -->

<div class="content_body">
<article>
	<h1>라인정보</h1>
	<form id="lineSearch">
		<div class="selectButtons">
			<button type="submit">조회</button>
			<button type="button" onclick="insertCheck()">추가</button>
		</div>
		
		<table class="searchBox">
			<tr>
				<td>라인코드</td>
				<td><input type="text" class="lineCode" name="lineCode"></td>
				<td>라인명</td>
				<td><input type="text" class="lineName" name="lineName"></td>
				<td>사용여부</td>
				<td><select name="useChoice">
						<option value="" selected>전체</option>
						<option value="Y">Y</option>
						<option value="N">N</option>
					</select></td>
			</tr>
		</table>
	
		<h1>목록</h1>
		
		<div class="listButtons">
			<span id="printCnt"></span>
		</div>
	
		<table border="1" class="lineList">
			<tr>
				<th>라인코드</th>
				<th>라인명</th>
				<th>작업장</th>
				<th>정렬순서</th>
				<th>사용여부</th>
				<th>비고</th>
				<th></th>
			</tr>
			<c:choose>
				<c:when test="${empty lineList}">
					<tr><td colspan="7"></td></tr>
					<tr>
						<td colspan="7">해당 라인 정보가 존재하지 않습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="lineDTO" items="${lineList}">
						<tr id="lineList">
							<td>${lineDTO.lineCode}</td>
							<td>${lineDTO.lineName}</td>
							<td>${lineDTO.linePlace}</td>
							<td>${lineDTO.sortOrder}</td>
							<c:choose>
								<c:when test="${lineDTO.useChoice eq 'Y'}">
									<td style="color: blue">${lineDTO.useChoice}</td>
								</c:when>
								<c:otherwise>
									<td style="color: red">${lineDTO.useChoice}</td>
								</c:otherwise>
							</c:choose>
							<td style="width: 250px">${lineDTO.note}</td>
							<c:if test="${! empty sessionScope.id}">
								<td><a style="cursor: pointer;"><img src='${pageContext.request.contextPath}/resources/image/modify.png' width='17px' onclick="modifyConfirm(${lineDTO.lineId})"></a></td>    
							</c:if>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
	</form>
	
	<div class="center">
	 	<div class="pagination">			
			<c:choose>
				<c:when test="${pageDTO.startPage > pageDTO.pageBlock}">
					<a href="/line/line?lineCode=${lineSearch.lineCode}&lineName=${lineSearch.lineName}&useChoice=${lineSearch.useChoice}&pageNum=${pageDTO.startPage - pageDTO.pageBlock}">◀</a>
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
			
			<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
				<a href="/line/line?lineCode=${lineSearch.lineCode}&lineName=${lineSearch.lineName}&useChoice=${lineSearch.useChoice}&pageNum=${i}" <c:if test="${pageDTO.pageNum eq i}">class="active"</c:if>>${i}</a>
			</c:forEach>
			
			<c:choose>
				<c:when test="${pageDTO.endPage < pageDTO.pageCount}">
					<a href="/line/line?lineCode=${lineSearch.lineCode}&lineName=${lineSearch.lineName}&useChoice=${lineSearch.useChoice}&pageNum=${pageDTO.startPage + pageDTO.pageBlock}">▶</a>
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	
</article>


	
</div>

<!-- <footer> -->
	<jsp:include page="../inc/footer.jsp" />
<!-- </footer> -->

</body>

<script>

$(document).ready(function() {
	
	// 라인 유효성 검사
	$('#lineSearch').submit(function() {
		if($('.lineCode').val() == "") {
			alert("라인코드를 입력해주세요.")
			$('.lineCode').focus();
			
			return false;
		}
		
		if($('.lineName').val() == "") {
			alert("라인명을 입력해주세요.")
			$('.lineName').focus();
			
			return false;
		}
	});
	
	// 라인 전체 목록 개수
	$('#printCnt').html("<span>총 " + ${totalCnt} + "건</span>");
	console.log(${totalCnt});
	
	// 라인 검색 목록 개수
	var count = '${searchCnt}';
	if(count != "") {
		$('#printCnt').html("<span>총 " + ${searchCnt} + "건</span>");
	}
	
});

function insertCheck() {
	// 라인 등록 로그인 후 가능
	// 세션값 받아오기
	var id = '<%=(String)session.getAttribute("id")%>';
	
	if(id == "null") {
		// 로그인 X, 로그인 페이지로 이동
		alert("로그인 후 이용하실 수 있습니다.");
		location.href='/login/login';
	} else {
		// 로그인 O, 등록 페이지로 이동
		window.open("/line/lineInsert", "popup", "width=500, height=500, left=600, top=200");
	}
}

// 라인 수정
function modifyConfirm(lineId) {
	window.open("/line/lineModify?lineId=" + lineId, "popup", "width=500, height=500, left=600, top=200");
}

</script>
</html>