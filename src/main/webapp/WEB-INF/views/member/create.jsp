<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 헤더 -->
<%@ include file="../inc/header.jsp"%><!-- 지우면안됨 -->
<link href="/resources/css/table.css"  rel="stylesheet" type="text/css">
<link href="/resources/css/common.css"  rel="stylesheet" type="text/css">
<!-- 자바스크립트 들어가는 곳 -->
<script type="text/javascript">


	$(document).ready(function() {
	
	
	});


	function check(){
		if($('#id').val()==""){
			alert("아이디 입력하세요");
			$('#id').focus();
			return false;
		}
		$.ajax({
			url:'/login/idCheck',
			data:{id:$('#id').val()},
			type:"post",
			success:function(result){
				if(result.trim()=="Y"){
					alert("이미 사용중인 아이디입니다.");
					$('#checkYn').val("N");
				}else{
					alert("사용가능한 아이디입니다.");
					$('#checkYn').val("Y");
					$('#checkId').val($('#id').val());
				}
			}
		})
	};

	
	function join() {
		if (!valChk($("#id"), "아이디")) return false;
		if (!idChk($('#id').val())) {
			alert("아이디는 숫자4글자로 입력하세요");
			$('#id').focus();
			return false;
		}
		
		if ($('#id').val().length != 4) { // 길이가 4가 아니면 
			alert("아이디는 숫자4글자로 입력하세요");
			$('#id').focus();
			return false;
		}
		
		if ($('#pass').val() == "") {
			alert("비밀번호는 6자이하로 입력해주세요");
			$('#pass').focus();
			return false;
		}
		
		if (!valChk($("#name"), "이름")) return false;
		
		if (!valChk($("#position"), "직책")) return false;
		
		if($("#email").val() != ""){
			if (!emailChk($("#email").val())) {
	 			alert('메일주소가 유효하지 않습니다.');
	 			$("#email").focus();
	 			return false;
	 		}
		} else {
			alert('이메일을 입력해주세요.');
 			$("#email").focus();
 			return false;
		}
		
		if(!valChk($("#tell"), "전화번호")) return false;
		if (!tellChk($("#tell").val())) {
 			alert('전화번호가 유효하지 않습니다.');
 			$("#tell").focus();
 			return false;
 		}
		
		if(!valChk($("#phone"), "핸드폰번호")) return false;
		if (!phoneChk($("#phone").val())) {
 			alert('핸드폰번호가 유효하지 않습니다.');
 			$("#phone").focus();
 			return false;
 		}
		
		if ($('#checkYn').val() != "Y") {
			alert("아이디 중복검사를 해주세요.");
			$('#id').focus();
			return false;
		}

		if ($('#id').val() != $('#checkId').val()) {
			alert("아이디 중복검사를 해주세요.");
			$('#id').focus();
			return false;
		}
		
		$('#join').submit();
	}
	
	

	function valChk(obj, alias) {
		if ($(obj).val() == "") {
			alert(alias + '을(를) 입력하세요.');
			$(obj).focus();
			return false;
		} else {
			return true;
		}
	}

	// 아이디 체크
	function idChk(val) {
		var regExp = /^[0-9]*$/ //0-9까지 입력할거다
		return regExp.test(val); // 형식에 맞는 경우 true 리턴
	}

	// 이메일 체크
	 	function emailChk(val) {
	 		var regExp = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	 		return regExp.test(val); // 형식에 맞는 경우 true 리턴
	 	}

	// 전화번호 체크
	 	function tellChk(val) {
	 		var regExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
	 		return regExp.test(val); // 형식에 맞는 경우 true 리턴
	 	}

	// 휴대폰 체크
	 	function phoneChk(val) {
	 		var regExp = /^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-(\d{4})$/;
	 		return regExp.test(val); // 형식에 맞는 경우 true 리턴
	 	}
	
	 // 전화번호 - 자동완성
	 	function autoHyphenTell(target) {
	 		target.value = target.value // target == this의 input
	 		.replace(/[^0-9]/g, "")
			.replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3")
			.replace("--", "-"); 
	 	}
	 
	// 휴대폰번호 - 자동완성
	 	function autoHyphen(target) {
	 		target.value = target.value // target == this의 input
			   .replace(/[^0-9]/g, '')
			  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
	 	}
	
</script>
<!-- 스크립트 끝. -->

<div class="content_body">
<!-- 내용시작 -->
<!-- 세션값 없으면 로그인화면으로 돌아가게 하는 것. -->
<c:if test="${empty sessionScope.id }">
	<c:redirect url="/login/login"></c:redirect>
</c:if>

	
	<h1>사용자 등록</h1><br><br>
	
	
	<div style="width: 60%">
		<form action="/member/insert" id="join" method="post"  >
			<input type="hidden" name="checkYn" id="checkYn" value="N">
			<input type="hidden" name="checkId" id="checkId" value="">
			<input type="hidden" name="insertId" id="insertId" value="${sessionScope.id }">
			<table>
				<colgroup>
					<col width="20%">
					<col width="*">
				</colgroup>
				<tbody>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="id" id="id" placeholder="아이디입력" maxlength="4">
						<input type="button" class="ml10" id="checkId" value="중복확인" onclick="check();">
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="pass" id="pass" placeholder="비밀번호" maxlength="6"></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="name" id="name" placeholder="이름을 입력해주세요"></td>
				</tr>
				<tr>
					<th>부서</th>
					<td>
						<select name="departments"  id="departments">	<!-- name,id 동일하게 -->
							<c:forEach items="${departmentComCdList }" var="codeDto">	<!--items="{컨트롤러에서 모델에 담은 이름. var =codeDTO로 쓰기.(큰의미는없음) }  -->
								<option value="${codeDto.cd }">${codeDto.cdNm }</option>	<!-- 그대로 가져다 쓰기 -->
							</c:forEach>
						</select>	
					</td>
				</tr>
				<tr>
					<th>직책</th>
					<td>
						<select name="position"  id="position">
							<c:forEach items="${positionComCdList }" var="codeDto">
								<option value="${codeDto.cd }">${codeDto.cdNm }</option>
							</c:forEach>
						</select>	
					</td>
				</tr>
				<tr>
					<th>이메일주소</th>
					<td><input type="text" name="email" id="email" placeholder="예)email@naver.com" ></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input type="text" name="tell" id="tell" placeholder="051-000-0000" oninput="autoHyphenTell(this)" maxlength="13"></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input type="text" name="phone"  id="phone" placeholder="010-0000-0000" oninput="autoHyphen(this)" maxlength="13"></td>
				</tr>
				<tr>
					<th>사용여부</th>
					<td>
						<input type="radio" name="useYn" value="Y" checked>사용 
						<input type="radio" name="useYn" value="N">미사용
					</td>
				</tr>
				</tbody>
			</table>
			<br><br>
			
			<div class="fr">
				<button type="button" class="btn" onclick="join();">등록</button>
				<button type="reset" class="btn">취소</button>
			</div>
			<div class="clear"></div>
		</form>
	</div>
	
	<!-- 내용끝 -->
</div>
<!-- 지우면안됨 -->
<!-- 헤더 -->
<%@ include file="../inc/footer.jsp"%><!-- 지우면안됨 -->