<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 헤더 -->
<%@ include file="../inc/header.jsp"%><!-- 지우면안됨 -->

<!-- 자바스크립트 들어가는 곳 -->
<script type="text/javascript">

	//searchResultColNames : 그리드 제목 행
	var searchResultColNames =  ['회원시퀀스', '아이디', '이름', '부서', '직책', '이메일', '전화번호', '휴대폰', '사용여부', '등록자', '등록일'];
	
	// searchResultColModel : 그리드 안에 들어가는 데이터
	var searchResultColModel =  [
	                  {name:'userId',  		index:'userId',  align:'center', hidden:true},
	                  {name:'id',   		index:'id',    align:'left',   width:'10%'},
	                  {name:'name',  		index:'name',  align:'center', width:'10%'},
	                  {name:'departments',	index:'departments', align:'center', width:'10%'},
	                  {name:'position',   	index:'position',   align:'center', width:'10%'},
	                  {name:'email',   		index:'email',   align:'center', width:'10%'},
	                  {name:'tell',   		index:'tell',   align:'center', width:'10%'},
	                  {name:'phone',  	 	index:'phone',   align:'center', width:'10%'},
	                  {name:'useYn',   		index:'useYn',   align:'center', width:'10%'},
	                  {name:'insertId',  	index:'insertId',   align:'center', width:'10%'},
	                  {name:'insertDt',   	index:'insertDt',   align:'center', width:'10%'}
	                ]; // name = dto변수명 index = 그리드에서 사용할 이름? , 옵션은 검색해서 사용

	$(function() { 
		// document.ready 와 같은 기능
		// DOM(Document Object Model)이 완전히 불러와지면 실행되는 Event
		// 페이지가 생길때 function안에 내용을 실행
	  searchData();
	  
	});	
	
	
	function searchData() { //그리드에 뿌려줄 데이터 조회용

		  $("#mainGrid").jqGrid({ // "#mainGrid" == <table id="mainGrid">
		    url : "/sample/searchList", // url주소
		    datatype : "JSON", // 데이터타입
		    postData : "",	// 넘겨줄데이터->넘겨줄게 없어서 ""공백. 검색어를 넣어준다.
		    mtype : "POST", // get,post방식
		    colNames: searchResultColNames, //위에 설정한 그리드 제목 행 틀
		    colModel: searchResultColModel, //위에 설정한 그리드 안에 들어가는 데이터 틀
		    rowNum : 10, // 줄 개수 (보여줄 데이터 개수) 
		    pager: "#pager", // 페이징할 div id
		    height: 261,
		    width: 1019
		  }); // 옵션은 검색해서 사용.
	}
	

</script>
<!-- 스크립트 끝. -->


<div class="content_body"> <!-- 지우면안됨 -->
	<!-- 내용시작 -->

	<h2>샘플메뉴</h2>
	
	<br><br><br>
	
	<!-- 그리드를 생성할 테이블 -->
	<table id="mainGrid"></table> <!-- 지우면 안됨 -->
	
	<!-- 그리드 페이징을 생성할 div -->
	<div id="pager"></div> <!-- 지우면 안됨 -->













	<!-- 내용끝 -->
</div><!-- 지우면안됨 -->
<!-- 푸터 -->
<%@ include file="../inc/footer.jsp"%><!-- 지우면안됨 -->
