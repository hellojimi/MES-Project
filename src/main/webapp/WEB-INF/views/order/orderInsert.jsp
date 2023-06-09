<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 헤더 -->
<%@ include file="../inc/header2.jsp"%><!-- 지우면안됨 -->
<style type="text/css">
 table {
      width: 650px;  
   } 
th,td{
border-bottom: 1px solid black;
padding: 10px;
}
#th {
	font-weight: bold;
}
#con {
	text-align: center;
}
#con:hover{
	background-color : #e1e1e1;
	cursor:pointer;
}
h1{
	font-weight: bold;
	font-size: 22.5px;
}
.search_bar tr, td{
 border:0px;
}
table#search {
 border:1px solid;
}
table#detail {
 border:1px solid;
}
table#info {
 border:1px solid;
}
#btn{
      width: 650px; 
	text-align: center;
 
}
#pagination{
      width: 600px;  
text-align: center;
}
#num:hover{
	background-color : #e1e1e1;
}
.form-control{
	width:150px;
	background-image: url('${pageContext.request.contextPath}/resources/image/calendar.png');
	background-repeat: no-repeat;
	background-position: 98%;
	border: 1px solid;
}
#clntNm {
	background-image: url('${pageContext.request.contextPath}/resources/image/magnifying-glass.png');
	background-repeat: no-repeat;
	background-position:98%;
	border: 1px solid;
}
#userNm{
	background-image: url('${pageContext.request.contextPath}/resources/image/magnifying-glass.png');
	background-repeat: no-repeat;
	background-position:98%;
	border: 1px solid;
}

#itemNum{
	background-image: url('${pageContext.request.contextPath}/resources/image/magnifying-glass.png');
	background-repeat: no-repeat;
	background-position:98%;
	border: 1px solid;
}
#itemNm {
	background-color: #EAEAEA;
	background-position:98%;
	border: 1px solid;
}
#invntUnit {
	background-color: #EAEAEA;
	background-position:98%;
	border: 1px solid;
}
#main{
	padding:20px;
}
#main span {
	color: red;
}
#main input {
   height: 20px;
}

</style>
</head>




<!-- 자바스크립트 들어가는 곳 -->
<script type="text/javascript">
function openItemList(){
        window.open("${pageContext.request.contextPath }/order/itemList","popup", "width=500, height=500,left=100, top=100");
    }
function openUserList(){
        window.open("${pageContext.request.contextPath }/order/userList","popup", "width=500, height=500,left=100, top=100");
    }
function openClntList(){
        window.open("${pageContext.request.contextPath }/order/clntList","popup", "width=500, height=500,left=100, top=100");
    }
$(function() {
	$("#orderDt").datepicker({
		 dateFormat: 'yy-mm-dd' //달력 날짜 형태
           ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
           ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
           ,changeYear: true //option값 년 선택 가능
           ,changeMonth: true //option값  월 선택 가능                
           ,buttonText: "선택" //버튼 호버 텍스트              
           ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
           ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
           ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
           ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
           ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
           ,maxDate: 0 // 0 : 오늘 날짜 이후 선택 X
           ,showButtonPanel: true // 캘린더 하단에 버튼 패널 표시
           ,currentText: '오늘' // 오늘 날짜로 이동하는 버튼 패널
           ,closeText: '닫기' // 닫기 버튼 패널
           ,onClose: function ( selectedDate ) {
        	   // 창이 닫힐 때 선택된 날짜가 endDate의 minDate가 됨
        	   $("input[name='dlvryDt']").datepicker("option", "minDate", selectedDate );
           }
	});
});
$(function() {
	$("#dlvryDt").datepicker({
		 dateFormat: 'yy-mm-dd' //달력 날짜 형태
           ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
           ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
           ,changeYear: true //option값 년 선택 가능
           ,changeMonth: true //option값  월 선택 가능                
           ,buttonText: "선택" //버튼 호버 텍스트              
           ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
           ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
           ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
           ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
           ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
           ,showButtonPanel: true // 캘린더 하단에 버튼 패널 표시
           ,currentText: '오늘' // 오늘 날짜로 이동하는 버튼 패널
           ,closeText: '닫기' // 닫기 버튼 패널
//            ,maxDate: 0 // 0 : 오늘 날짜 이후 선택 X
	});
});
$(document).ready(function(){
	$('#insertOrder').submit(function() {
	
	if ($('#clntNm').val()=="") {
		alert("업체명을 입력하세요");
		$('#clntNm').focus();
		return false;
	}
	
	if ($('#orderDt').val()=="") {
		alert("수주일자를 입력하세요");
		$('#orderDt').focus();
		return false;
	}
	
	if ($('#userNm').val()=="") {
		alert("담당자를 입력하세요");
		$('#userNm').focus();
		return false;
	}
	
	if ($('#dlvryDt').val()=="") {
		alert("납품예정일을 입력하세요");
		$('#dlvryDt').focus();
		return false;
	}
	
	if ($('#itemNum').val()=="") {
		alert("품번을 입력하세요");
		$('#clntNm').focus();
		return false;
	}
	
	if ($('#ordQty').val()=="") {
		alert("수량을 입력하세요");
		$('#ordQty').focus();
		return false;
	}
	
});
});

// $(function(){
//     $("#insertOrder").submit(function(event){
//       alert("저장되었습니다.");
//         return true;
//     });
// });
</script>
<!-- 스크립트 끝. -->
<body>
<div id="main" > 

	<h1>수주품목상세</h1>
		<form id="insertOrder" action="${pageContext.request.contextPath }/order/orderInsertPro" method="get">
	<div class="orderdetail">
				<br>
			<table id="detail">
				<tr>
				<td>업체명 <span>*</span></td>
				<td><input type="hidden" name="insertId" id="insertId" value="${sessionScope.id}" readonly>
					<input type="text" name="clntNm" id="clntNm" onclick="openClntList()">
					<input type="hidden" name="clntId" id="clntId" value="">
					<input type="hidden" name="clntCd" id="clntCd" value=""></td>
				<td>수주일자 <span>*</span></td>
				<td><input type="text" id="orderDt" class="form-control" name="orderDt" placeholder="날짜를 선택해주세요" readonly>
				<td></td>
				</tr>
				<tr>
				<td>담당자 <span>*</span></td>
				<td><input type="text" name="userNm" id="userNm" onclick="openUserList()">
					<input type="hidden" name="userId" id="userId"value="">
					<input type="hidden" name="userNum" id="userNum" value=""></td>
				<td>납품예정일 <span>*</span></td>
				<td><input type="text" id="dlvryDt" class="form-control" name="dlvryDt" placeholder="날짜를 선택해주세요" readonly></td>
				<td></td>

				<td></td>
				<td></td>
				</tr>
			</table>
	</div>
<br>
<br>
	<h1>수주정보</h1>
	<br>
	<div class="orderinfo">
			<table id="info">
				<tr>
				<td>품번 <span>*</span></td>
				<td><input type="hidden" name="itemId" id="itemId"  onclick="openItemList()">
					<input type="text" name="itemNum" id="itemNum"  onclick="openItemList()"></td>
				<td><input type="text" name= "itemNm" id="itemNm"  readonly="readonly" placeholder="품명"></td>
				<td><input type="text" name="invntUnit" id="invntUnit" readonly="readonly" value="" placeholder="단위"></td>
				</tr>
				<tr>
				<td>수량 <span>*</span></td>
				<td><input type="text" name="ordQty" id="ordQty" value="" placeholder="필수입력"></td>
				</tr>
			</table>
			<br>
				<div id="btn">
				<button type="reset">취소</button>
				<button type="submit" value="저장" class="submit">저장</button>
			</div>
	</div>
		</form>
<br>

</div>

</body>
<!-- 푸터 -->
<%-- <%@ include file="../inc/footer.jsp"%><!-- 지우면안됨 --> --%>