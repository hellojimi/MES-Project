<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!-- 헤더 -->
<%@ include file="../inc/header.jsp" %><!-- 지우면안됨 -->

<!-- 자바스크립트 들어가는 곳 -->
<script type="text/javascript">

</script>
<!-- 스크립트 끝. -->


<div class="content_body"> <!-- 지우면안됨 -->
<!-- 내용시작 -->
<%
//세션값 전체 삭제
session.invalidate();
//로그아웃 메시지 출력  main.jsp 이동
%>
<script type="text/javascript">
	alert("로그아웃");
	location.href="main.jsp";
</script>

<!-- 내용끝 -->
</div><!-- 지우면안됨 -->
<!-- 헤더 -->
<%@ include file="../inc/footer.jsp" %><!-- 지우면안됨 -->


