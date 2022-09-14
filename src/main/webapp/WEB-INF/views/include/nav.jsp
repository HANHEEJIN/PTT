<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">

</script>
<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

	<!-- Topbar Navbar -->
	<ul class="navbar-nav ml-auto">
		<!-- Nav Item - User Information -->
		<li class="nav-item dropdown no-arrow">
			<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown"  > 
				
				<i class="fas fa-laugh-wink" style="color: yellow"> </i> 
				<c:if test="${not empty sessionId}">
					<span style="color: yellow">${sessionId.user_id}</span>
					<input type="hidden" id="sessionId" value="${sessionId.user_id}" style="display:none;"></input>
				</c:if>
				<c:if test="${empty sessionId}">
					<div style="color: yellow"><h4>로그인정보없음</h4></div>
				</c:if>
			</a>
			<!-- Dropdown - User Information -->
			<div class="dropdown-menu dropdown-menu-right"	>
			
				<a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal" >
					<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
					<c:if test="${not empty sessionId}">
						<div style="color: red">로그아웃</div>
					</c:if>
					<c:if test="${empty sessionId}">
						<div style="color: red">로그인정보 없음</div>
					</c:if>
				</a>
			</div>
		</li>
	</ul>
	
			
	<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">로그인 & 로그아웃</h5>
				<button class="close" type="button" data-dismiss="modal"aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<c:choose>
				<c:when test="${empty sessionId}"> <!-- 객체 값이 있으면 <-> 없으면 empty -->
					<div class="modal-body">로그인 정보가 없습니다.</div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button"	data-dismiss="modal">취소</button>
						<a class="btn btn-primary" href="<c:url value="/"/>">로그인</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="modal-body">로그아웃</div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button"	data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-success" id="btnLogOut" onclick="logOut()">로그아웃</button>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>		
</div>
	<!-- Divider -->
	<hr class="sidebar-divider my-0">

	<!-- Heading -->
	<div class="sidebar-heading">관리</div>
	
	<!-- 메뉴 -->
	<li class="nav-item"> <a class="nav-link" href="<c:url value="/dashBoard"/>"> <i class="fas fa-fw fa-tachometer-alt"></i> <span>대쉬보드</span></a> </li>
	<li class="nav-item"> <a class="nav-link" href="<c:url value="/user/listUser.do"/>"><i class="fa fa-users"></i><span>사용자관리</span></a></li>

	<li class="nav-item">
		<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#department" aria-expanded="true" aria-controls="department">
			<i class="fa fa-th-large"></i>
			<span>부서관리</span>
		</a>
		<div id="department" class="collapse" aria-labelledby="headingDepartment" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<a class="collapse-item" href="<c:url value="/dpart/insertDpartForm"/>">부서등록</a>
				<a class="collapse-item" href="<c:url value="/dpart/listDpart.do"/>">부서목록</a>
			</div>
		</div>
	</li>

	<li class="nav-item"> <a class="nav-link" href="<c:url value="/equip/listEqp.do"/>"><i class="fas fa-fw fa-wrench"></i><span>장비관리</span></a></li>
	<li class="nav-item"> <a class="nav-link" href="<c:url value="/chat/listChat.do"/>"><i class="fa fa-comments"></i><span>대화방</span></a></li>

	<!-- Nav Item - Utilities Collapse Menu -->
	<li class="nav-item">
		<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#server" aria-expanded="true" aria-controls="server">
			<i class="fa fa-server"></i> <span>서버관리</span>
		</a>
		<div id="server" class="collapse" aria-labelledby="headingServer" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<h6 class="collapse-header">SIP관리</h6>
				<a class="collapse-item" href="<c:url value="/server/listSip.do" />">SIP목록</a>
			</div>
			<div class="bg-white py-2 collapse-inner rounded">
				<h6 class="collapse-header">MQTT관리</h6>
				<a class="collapse-item" href="<c:url value="/server/listMqtt.do" />">MQTT목록</a>
			</div>
		</div>
	</li>
	<!-- Divider -->
	<hr class="sidebar-divider">
</ul>
<!-- End of Sidebar -->