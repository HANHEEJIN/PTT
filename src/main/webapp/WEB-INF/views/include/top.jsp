<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style> 
span { display:inline-block; width:100px; font-size:small; text-align:center;} 

</style>
<!-- <style>span { display:inline-block; width:70px; font-size:small; text-align:center;}</style>
 -->
<body id="page-top">
<!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow" style="margin-bottom: 0px!important;">
	<!-- Sidebar Toggle (Topbar) -->
	<button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
		<i class="fa fa-bars"></i>
	</button>

	<!-- 로그인 정보 있으면 -->	
	<%-- <c:if test="${not empty sessionId}"> <a class="collapse-item" href="<c:url value="/dashBoard" />">큰 사람 커넥트</a> </c:if> --%>
	
	<!-- 로그인 정보 없으면 -->
	<%-- <c:if test="${empty sessionId}"> <a class="collapse-item" href="<c:url value="/" />">큰 사람 커넥트</a> </c:if> --%>
	
	<!--
	관리자 : SUS_ADMIN 
	사용자 : SUS_USER
	게스트 : 
	로그인 정보 X : EMPTY
	나머지 : GUEST
	-->

	
	<c:choose>
		<c:when test="${sessionId.user_lvl eq 'a' or 'A'}"> <a class="collapse-item" href="<c:url value="/dashBoard" />">큰 사람 커넥트</a> </c:when>
		<c:when test="${sessionId.user_lvl eq 'u' or 'U' }"> <a class="collapse-item" href="<c:url value="/dashBoardGuest" />">큰 사람 커넥트</a> </c:when>
		<c:when test="${empty sessionId}"> <a class="collapse-item" href="<c:url value="/" />">큰 사람 커넥트</a> </c:when> 
		<c:otherwise> <a class="collapse-item" href="<c:url value="/dashBoardGuest" />">큰 사람 커넥트</a> </c:otherwise>
	</c:choose>
	
	<!-- <a class="collapse-item" href="javascript:roleMain();">큰 사람 커넥트</a>  -->
	
</nav>
 <!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
	<i class="fas fa-angle-up"></i>
</a>


<script>
/* function roleMain(){
	console.log('dddddd');
	// 로그인 관련 메세지
	let loginMsg = '<c:out value="${LOGIN}" />';
	let url = '';
	console.log('loginMsg' + loginMsg);
	
	if(loginMsg != ''){
		if(loginMsg == 'SUS_ADMIN') {
			url = '/dashBoard';
		} else if(loginMsg == 'SUS_USER') {
			url = '/dashBoardGuest';
		} else if(loginMsg == 'USER_INFO_ERROR') {
			url = '/';
		} else if(loginMsg == 'FAIL') {
			url = '/';
		} else {
			url = '/';
		}
		window.location.href = url;
	}
} */

</script>