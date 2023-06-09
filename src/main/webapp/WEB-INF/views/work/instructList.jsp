<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <title>instructList</title> -->

<link href="${pageContext.request.contextPath}/resources/css/instruct/instrList.css" rel="stylesheet" type="text/css">
<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="32x32" href="/resources/image/favicon-32x32.png">

<style type="text/css">

.content_body .searchBox #pcd {
	background-image: url('${pageContext.request.contextPath}/resources/image/magnifying-glass.png');
	background-repeat: no-repeat;
	background-position: 98%;
	border: 1px solid;
}

.content_body .searchBox .form-control {
	width: 150px;
	background-image: url('${pageContext.request.contextPath}/resources/image/calendar.png');
	background-repeat: no-repeat;
	background-position: 98%;
	border: 1px solid;
}
	
</style>
</head>



<body>
<!-- <header> -->
	<jsp:include page="../inc/header.jsp" />
<!-- </header> -->

<div class="content_body">
<article>
	<h1>작업지시 정보관리</h1>
	<form id="instr">
		<div class="selectButtons">
			<button type="submit" id="submit">조회</button>
			<button type="button" onclick="loginCheck()">추가</button>
		</div>
		
		<table class="searchBox">
			<tr>
				<td>라인</td>
				<td><select name="lineName" class="lineName">
						<option value="" selected>전체</option>
						<c:forEach var="line" items="${lineList}">
							<option value="${line.lineName}">${line.lineName}</option>
						</c:forEach>
					</select></td>
				<td>지시일자</td>
				<!-- 시작시 기본 날짜 설정은 value를 이용 -->
				<td><input type="text" id="sDate" class="form-control" name="startDate" placeholder="날짜를 선택해주세요" readonly />
		   			<input type="text" id="eDate" class="form-control" name="endDate" readonly /></td>
			</tr>
			<tr>	
				<td>품번</td>
				<td><input type="hidden" id="pid" name="pid">
					<input type="text" id="pcd" name="itemNum" placeholder="품번코드" onclick="openItem()">
					<input type="text" id="pnm" placeholder="품명" style="border:1px solid" readonly></td>
				<td>지시상태</td>
				<td colspan="8">
					<input type="checkbox" name="workSts1" value="지시" class="sCheck">지시
					<input type="checkbox" name="workSts2" value="시작" class="sCheck">시작
					<input type="checkbox" name="workSts3" value="마감" class="sCheck">마감
				</td>
			</tr>
		</table>
	

		<h1>목록</h1>
		
		<div class="listButtons">
			<span id="printCnt"></span>
		</div>
		
		<table border="1" class="instrList">
			<tr>
				<th rowspan="2">작업지시번호</th>
				<th rowspan="2">업체</th>
				<th rowspan="2">수주번호</th>
				<th rowspan="2">지시일자</th>
				<th rowspan="2">지시상태</th>
				<th colspan="3">품목정보</th>
				<th colspan="2">공정정보</th>
				<th rowspan="2">지시수량</th>
				<th rowspan="2">등록일</th>
				<th rowspan="2">등록자</th>
				<th rowspan="2"></th>
			</tr>
			<tr>
				<th>품번</th>
				<th>품명</th>
				<th>단위</th>
				<th>라인</th>
				<th>라인명</th>
			</tr>
			<c:choose>
				<c:when test="${empty instrList}">
					<tr><td colspan="15"></td></tr>
					<tr>
						<td colspan="15">작업지시 목록이 존재하지 않습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="instrDTO" items="${instrList}">
						<tr id="instrList">
							<td style="width: 170px;">${instrDTO.workNum}</td>
							<td style="width: 120px;">${instrDTO.clntDTO.clientName}</td>
							<td style="width: 160px;">${instrDTO.orderMngDTO.ordNum}</td>
							<td>${instrDTO.workDate}</td>
							<c:choose>
								<c:when test="${instrDTO.workSts eq '시작' }">
									<td style="color: green;">${instrDTO.workSts}</td>
								</c:when>
								<c:when test="${instrDTO.workSts eq '마감' }">
									<td style="color: red;">${instrDTO.workSts}</td>
								</c:when>
								<c:otherwise>
									<td>${instrDTO.workSts}</td>
								</c:otherwise>
							</c:choose>
							<td>${instrDTO.itemDTO.itemNum}</td>
							<td>${instrDTO.itemDTO.itemName}</td>
							<td>${instrDTO.itemDTO.invntUnit}</td>
							<td>${instrDTO.lineDTO.lineCode}</td>
							<td>${instrDTO.lineDTO.lineName}</td>
							<td>${instrDTO.workQty}</td>
<%-- 							<td><tf:FormatDateTime value="${instrDTO.insertDate}" pattern="yyyy-MM-dd" /></td> --%>
							<td><fmt:formatDate value="${instrDTO.insertDate}" pattern="yyyy-MM-dd"/></td>
							<td>${instrDTO.userDTO.name}</td>
							<c:if test="${! empty sessionScope.id && instrDTO.workSts eq '지시'}">
								<td><a style="cursor: pointer;"><img src='${pageContext.request.contextPath}/resources/image/modify.png' width='17px' onclick="instrModify(${instrDTO.instrId})"></a>
									<a style="cursor: pointer;"><img src='${pageContext.request.contextPath}/resources/image/del.png' width='17px' onclick="instrDelete(${instrDTO.instrId})"></a></td>
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
					<a href="/work/instructList?lineName=${instrSearch.lineName}&startDate=${instrSearch.startDate}&endDate=${instrSearch.endDate}&itemNum=${instrSearch.itemNum}&workSts1=${instrSearch.workSts1}&workSts2=${instrSearch.workSts2}&workSts3=${instrSearch.workSts3}&pageNum=${pageDTO.startPage - pageDTO.pageBlock}">◀</a>
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
			
			<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
				<a href="${pageContext.request.contextPath}/work/instructList?lineName=${instrSearch.lineName}&startDate=${instrSearch.startDate}&endDate=${instrSearch.endDate}&itemNum=${instrSearch.itemNum}&workSts1=${instrSearch.workSts1}&workSts2=${instrSearch.workSts2}&workSts3=${instrSearch.workSts3}&pageNum=${i}" <c:if test="${pageDTO.pageNum eq i}">class="active"</c:if>>${i}</a>
			</c:forEach>
			
			<c:choose>
				<c:when test="${pageDTO.endPage < pageDTO.pageCount}">
					<a href="${pageContext.request.contextPath}/work/instructList?lineName=${instrSearch.lineName}&startDate=${instrSearch.startDate}&endDate=${instrSearch.endDate}&itemNum=${instrSearch.itemNum}&workSts1=${instrSearch.workSts1}&workSts2=${instrSearch.workSts2}&workSts3=${instrSearch.workSts3}&pageNum=${pageDTO.startPage + pageDTO.pageBlock}">▶</a>
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		</div>
	</div> <!-- 페이징 -->
	
</article>
</div>

<!-- <footer> -->
	<jsp:include page="../inc/footer.jsp" />
<!-- </footer> -->

</body>

<script>

$(function() {
	$("#sDate").datepicker({
		 dateFormat: 'yy-mm-dd' //달력 날짜 형태
           ,showOtherMonths: true //빈 공간에 현재 월의 앞뒤 월의 날짜를 표시
           ,showMonthAfterYear:true // 월- 년 순서가 아닌 년도 - 월 순서
           ,changeYear: true //option값 년 선택 가능
           ,changeMonth: true //option값  월 선택 가능     
           ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
           ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
           ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
           ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
           ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
           ,maxDate: 0 // 0 : 오늘 날짜 이후 선택 X
           ,showButtonPanel: true // 캘린더 하단에 버튼 패널 표시여부
           ,currentText: '오늘' // 오늘 날짜로 이동하는 버튼 패널
           ,closeText: '닫기' // 닫기 버튼 패널
           ,onClose: function ( selectedDate ) {
        	   // 창이 닫힐 때 선택된 날짜가 endDate의 minDate가 됨
        	   $("input[name='endDate']").datepicker("option", "minDate", selectedDate );
           }
	});
});

$(function() {
	$("#eDate").datepicker({
		 dateFormat: 'yy-mm-dd' //달력 날짜 형태
           ,showOtherMonths: true //빈 공간에 현재 월의 앞뒤 월의 날짜를 표시
           ,showMonthAfterYear:true // 월- 년 순서가 아닌 년도 - 월 순서
           ,changeYear: true //option값 년 선택 가능
           ,changeMonth: true //option값  월 선택 가능              
           ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
           ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
           ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
           ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
           ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
           ,showButtonPanel: true // 캘린더 하단에 버튼 패널 표시
           ,currentText: '오늘' // 오늘 날짜로 이동하는 버튼 패널
           ,closeText: '닫기' // 닫기 버튼 패널
           ,maxDate: 0 // 0 : 오늘 날짜 이후 선택 X
	});
});

// 오늘 버튼 패널 클릭 시 오늘 날짜 입력과 동시에 캘린더 닫힘
$('button.ui-datepicker-current').live('click', function() {
	$('#sDate, #eDate').datepicker('setDate', 'today').datepicker('hide').blur();
})

// 품명 검색 팝업창
function openItem(){
    window.open("${pageContext.request.contextPath}/work/itemList","popup", "width=500, height=500,left=100, top=100");
}

// 작업지시 유효성 검사
$(document).ready(function() {
	$('#instr').submit(function() {
		if($('#sDate').val() == "") {
			alert("지시일자를 선택해주세요.");
			$('#sDate').focus();
			
			return false;
		}
		
		if($('#pcd').val() == "") {
			alert("품번코드를 입력해주세요.");
			$('#pcd').focus();
			
			return false;
		}
	});
	
	// 전체 목록 개수
	$('#printCnt').html("<span>총 " + ${instrTotal} + "건</span>");
	console.log(${instrTotal});
	
	// 검색 목록 개수
	var count = '${instrSearchCount}';
	if(count != "") {
		$('#printCnt').html("<span>총 " + ${instrSearchCount} + "건</span>");
	}
	console.log("getSearchCnt");
	
});

// 작업지시 등록 버튼 유효성 검사
function loginCheck() {
	
	// 세션값 받아오기
	var id = '<%=(String)session.getAttribute("id")%>';
	
	if(id == "null") {
		// 로그인 X, 로그인 페이지로 이동
		alert("로그인 후 이용하실 수 있습니다.");
		location.href='/login/login';
	} else {
		// 로그인 O, 등록 페이지로 이동
		window.open("/work/instructInsert", "popupInsert", "width=700, height=700, left=600, top=200");
	}
}

// 작업지시 수정
function instrModify(instrId) {
	window.open("/work/instructModify?instrId=" + instrId, "popupModify", "width=700, height=700, left=600, top=200");
}

// 작업지시 삭제
function instrDelete(instrId) {
	if(confirm("삭제하시겠습니까?")) {
		location.href="/work/instructDelete?instrId=" + instrId;
	} else {
		return false;
	}
	
}


</script>
</html>