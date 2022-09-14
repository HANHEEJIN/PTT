<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
	
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- <META HTTP-EQUIV="refresh" CONTENT="15">  --><!-- 자동 새로고침 META 태그 -->

    <title>LTE PTT</title>

    <!-- Custom fonts for this template-->
    <link href="${path}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    
     <!-- Custom styles for this template-->
    <link href="${path}/resources/css/sb-admin-2.min.css" rel="stylesheet">
    
    <!-- Custom styles for this page -->
	<link href="${path}/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
	
	<link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css" rel="stylesheet">
	
	<!--Data table CSS -->
	<%-- <link rel="stylesheet" type="text/css" href="${path}/resources/vendor/datatables/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/resources/vendor/datatables/responsive.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/resources/vendor/datatables/dataTableMain.css"> --%>

	<!-- Bootstrap core JavaScript-->
	<script src="${path}/resources/vendor/jquery/jquery.min.js" type="text/javascript"></script>
	<script src="${path}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js" type="text/javascript"></script>
	
	<!-- dataTable -->
	<%-- <script src="${path}/resources/vendor/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
	<script src="${path}/resources/vendor/datatables/dataTables.responsive.min.js"></script>
	<script src="${path}/resources/vendor/datatables/dataTables.buttons.min.js"></script>
	<script src="${path}/resources/vendor/bootstrap/js/buttons.html5.min.js"></script>
	<script src="${path}/resources/vendor/datatables/dataTables.bootstrap4.min.js" type="text/javascript"></script> --%>
	<!-- dataTble file download -->
	<!-- 
	https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js
	https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js
	 -->
	<!-- <script src="https://code.jquery.com/jquery-3.4.1.js"></script> -->
	<script src="${path}/resources/js/jquery.form.js"></script>
	<script src="${path}/resources/js/jquery.serialize-object.js"></script>
	
  
	<!-- Core plugin JavaScript-->
	<script src="${path}/resources/vendor/jquery-easing/jquery.easing.min.js" type="text/javascript"></script>
	
	<!-- Custom scripts for all pages-->
	<script src="${path}/resources/js/sb-admin-2.min.js" type="text/javascript"></script>
    
	<script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>
	
	<!-- MQTT JS -->
	<script src="${path}/resources/js/mqttws31.js"></script>
	<script src="${path}/resources/js/mqttws31-min.js"></script>
		
	<!-- T MAP API  -->
	<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xxecf46fba372943a78b3a61b6e8997ff9"></script>
	
	<!-- jquery.treeview -->
	<%-- <script src="${path}/resources/js/jquery.treeview.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="${path}/resources/js/jquery.treeview.css">
 --%>	
	<!-- Required Stylesheets -->
	<link href="bootstrap.css" rel="stylesheet">

	<!-- Required Javascript -->
	<link  href="${path}/resources/js/bootstrap-treeview.min.css" rel="stylesheet" type="text/css">
	<script src="${path}/resources/js/bootstrap-treeview.min.js" type="text/javascript"></script>
	
	<!-- mqttClient -->
	<script src="${path}/resources/ptt/mqttClient.js"></script>
	

	<!-- ptt 관련 -->
	<script src="${path}/resources/ptt/user.js"></script>
	<script src="${path}/resources/ptt/mqtt.js"></script>
	<script src="${path}/resources/ptt/sip.js"></script>
	<script src="${path}/resources/ptt/eqp.js"></script>
	<script src="${path}/resources/ptt/company.js"></script>
	<script src="${path}/resources/ptt/dpart.js"></script>
	<script src="${path}/resources/ptt/chat.js"></script>
	<script src="${path}/resources/ptt/common.js"></script>
	<script src="${path}/resources/ptt/map.js"></script>
	
	<style>	
		/* 데스크탑 */
		/* 브라우저 창 width가 1024px보다 커지는 순간부터 적용,  */
		@media all and (min-width: 1024px){
			body { 
			min-width:768px; overflow: auto hidden scroll; white-space:nowrap; text-overflow:ellipsis; 
			/* font-family: 'Nanum Gothic', sans-serif; */
			}
			/* input { font-family: 'Jeju Gothic', sans-serif; } */
			table {	white-space:nowrap; text-align: center;	width: 100%; }	 /* 테이블 줄바꿈 방지 */
			button{ white-space:nowrap; text-align: center; overflow:hidden} /* 버튼 줄바꿈 방지 */
			
			/* 사용자 구분 (type) */
			.radio_form_parent{ display: inline-block; overflow: hidden; position: relative; width: 100%} /* 버튼 토글 방지 */
			.radio_form_child_a, .radio_form_child_u, .view_user_lvl_a, .view_user_lvl_u
			{ display: inline-block; width: 50%; position: absolute;  top: 0; float: left;}
			.radio_form_child {display: inline-block; width: 100%; }
			
			/* 사용자 수정 비번 변경  */
			.div_pw_parent {display: inline-block; width: 100%;}
			.div_pw_child {display: inline-block; width: 50%; float: left;}
			
			
			/* 사용자 리스트 엑셀 업 다운 버튼  */
			.div_excel_btn {justify-content: end;}
			.div_btn_parent {display: inline-block; max-width: 50%;}
			.btn_child {display: inline-block; width: 100%;}
			
			
			/* 모달창 제목 */
			.modal-title {overflow: hidden; text-overflow: ellipsis;}
			
			
			html {font-size:13px}
			.btn-sm{font-size:0.1rem;}
			.btn{font-size:0.3rem;}
			.btn-lg{font-size:0.5rem;}
		}
		
		/* 태블릿 가로 세로*/
		/* 브라우저 창 width가 768px보다 커지는 순간과 1024px보다 작아지는 순간부터 적용,  */
		@media all and (min-width: 768px ) and (max-width:1023px) {
			body { 
			min-width:768px; overflow: auto hidden scroll; white-space:nowrap; text-overflow:ellipsis; 
		/* 	font-family: 'Jeju Gothic', sans-serif; */
			}
			/* input { font-family: 'Nanum Gothic', sans-serif; } */
			table {	white-space:nowrap; text-align: center;	width: 100%; }	 /* 테이블 줄바꿈 방지 */
			button{ white-space:nowrap; text-align: center; overflow:hidden} /* 버튼 줄바꿈 방지 */
			
			/* 사용자 구분 (type) */
			.radio_form_parent{ display: inline-block; overflow: hidden; position: relative; width: 100%} /* 버튼 토글 방지 */
			.radio_form_child_a, .radio_form_child_u, .view_user_lvl_a, .view_user_lvl_u{ display: inline-block; width: 50%; position: absolute;  top: 0; float: left;}
			.radio_form_child {display: inline-block; width: 100%; }
			
			
			/* 사용자 수정 비번 변경  */
			.div_pw_parent {display: inline-block; width: 100%;}
			.div_pw_child {display: inline-block; width: 50%; float: left;}
			
			
			/* 사용자 리스트 엑셀 업 다운 버튼  */
			.div_excel_btn {justify-content: end;}
			.div_btn_parent {display: inline-block; max-width: 50%;}
			.btn_child {display: inline-block; width: 100%;}
			
			/* 모달창 제목 */
			.modal-title {overflow: hidden; text-overflow: ellipsis;}
			
			html {font-size:13px}
			.btn-sm{font-size:0.1rem;}
			.btn{font-size:0.3rem;}
			.btn-lg{font-size:0.5rem;}
		}
		
		/* 모바일 */
		/* 브라우저 창 width가 768px보다 작아지는 순간부터 적용,  */
		@media all and (max-width: 767px){
			body { 
			min-width:768px; overflow: auto hidden scroll; white-space:nowrap; text-overflow:ellipsis; 
			/* font-family: 'Nanum Gothic', sans-serif; */
			}
			/* button { overflow:hidden; } */ /* 버튼 글자 넘어가면 숨기기 */
			/* input { font-family: 'Jeju Gothic', sans-serif; } */
			
			table {	white-space:nowrap; text-align: center;	width: 100%; }	 /* 테이블 줄바꿈 방지 */
			button{ white-space:nowrap; text-align: center; overflow:hidden} /* 버튼 줄바꿈 방지 */
			
			/* 사용자 구분 (type) */
			.radio_form_parent{ display: inline-block; overflow: hidden; position: relative; width: 100%} /* 버튼 토글 방지 */
			.radio_form_child_a, .radio_form_child_u, .view_user_lvl_a, .view_user_lvl_u{ display: inline-block; width: 50%; position: absolute;  top: 0; float: left;}
			.radio_form_child {display: inline-block; width: 100%; }

			/* 사용자 수정 비번 변경  */
			.div_pw_parent {display: inline-block; width: 100%;}
			.div_pw_child {display: inline-block; width: 50%; float: left;}
			

			/* 사용자 리스트 엑셀 업 다운 버튼  */
			.div_excel_btn {justify-content: end;}
			.div_btn_parent {display: inline-block; max-width: 50%;}
			.btn_child {display: inline-block; width: 100%;}
			
			/* 모달창 제목 */
			.modal-title {overflow: hidden; text-overflow: ellipsis;}

			
			
			
			 html {font-size:13px}
			.btn-sm{font-size:0.1rem;}
			.btn{font-size:0.3rem;}
			.btn-lg{font-size:0.5rem;}
		}
		
		/* 모바일 가로, 테블릿 세로 (해상도 ~ 479px)*/ 
		@media all and (max-width:479px){
			body { 
			min-width:768px; overflow: auto hidden scroll; white-space:nowrap; text-overflow:ellipsis; 
			/* font-family: 'Nanum Gothic', sans-serif; */
			}
			/* button { overflow:hidden; } */ /* 버튼 글자 넘어가면 숨기기 */
			/* input { font-family: 'Jeju Gothic', sans-serif; } */
			
			table {	white-space:nowrap; text-align: center;	width: 100%; }	 /* 테이블 줄바꿈 방지 */
			button{ white-space:nowrap; text-align: center; overflow:hidden} /* 버튼 줄바꿈 방지 */
			
			/* 사용자 구분 (type) */
			.radio_form_parent{ display: inline-block; overflow: hidden; position: relative; width: 100%} /* 버튼 토글 방지 */
			.radio_form_child_a, .radio_form_child_u, .view_user_lvl_a, .view_user_lvl_u{ display: inline-block; width: 50%; position: absolute;  top: 0; float: left;}
			.radio_form_child {display: inline-block; width: 100%; }
			
			/* 사용자 수정 비번 변경  */
			.div_pw_parent {display: inline-block; width: 100%;}
			.div_pw_child {display: inline-block; width: 50%; float: left;}
			
			/* 사용자 리스트 엑셀 업 다운 버튼  */
			.div_excel_btn {justify-content: end;}
			.div_btn_parent {display: inline-block; max-width: 50%;}
			.btn_child {display: inline-block; width: 100%;}
			
			/* 모달창 제목 */
			.modal-title {overflow: hidden; text-overflow: ellipsis;}
			
			 html {font-size:13px}
			.btn-sm{font-size:0.1rem;}
			.btn{font-size:0.3rem;}
			.btn-lg{font-size:0.5rem;}
		}
		

	</style>
</head>