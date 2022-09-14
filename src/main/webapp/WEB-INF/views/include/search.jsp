<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ include file="../include/top.jsp"%> --%>

<!--검색 기능 -->
<%-- <form action="${path}/search" name="search"> --%> <!-- controlle의 value="search" -->

<!-- row start -->
<!--  form frmlist -->
<form name="search" method="get" <%-- action="${path}/user/listUser.do" --%> onsubmit='return false'>
<div class="row">

	<div class="col-sm-3"></div>
	
	
	<div class="col-sm-2">
		
		<select name="searchType" class="form-control" >
			<!--  eq(==)  / ne(!=)  / <(lt) / >(gt) / <=(le) / >=(ge)
			/ empty : null(true), not null(false) / not empty : not null -->
			<!-- 삼항연산자 : 'NAME'? 'selected': '' -> name이면, 선택 -->
			<!-- c out : 특수문자 탈락, 보안성xss -->
			<!-- 
			<option value="user_nm" <c:out value="${map.searchType eq 'user_nm'.toString()?'selected':'' }"/>> 이름 </option>
			<option value="user_id" <c:out value="${map.searchType eq 'user_id'.toString()?'selected':'' }"/>> 아이디 </option>
			<option value="editor" <c:out value="${map.searchType eq 'editor'.toString()?'selected':'' }"/>> 작성자 </option>
			<option value="NIE" <c:out value="${map.searchType eq 'NIE'.toString()?'selected':'' }"/>> 이름 + 아이디 + 작성자</option>
			 -->
			 <option value="" selected>선택</option>
		</select>
	</div>
	
	<div class="col-sm-4">
		<div class="input-group">
			<input type="text" class="form-control small" name="keyword" placeholder="검색어"/>
			<div class="input-group-append">
				<!-- <input type="submit"  value="검색하기" data-role="button"/> -->
				<button type="submit" class="btn btn-primary btn-sm"> <i class="fas fa-search fa-sm" ></i> 검색</button>
			</div>
		</div>
		
	</div>
	<div class="col-sm-3"></div>
</div> 
</form>
<!-- row end -->
<br>

<!--검색 기능 -->
<%-- <form name="search" action="${path}/board/listBoardJson.do/{page}" > <!-- controlle의 value="search" -->

	<div class="row">

		<div class="col-sm-3"></div>
		
		<div class="col-sm-2">
			<div class="form-group">
				<select name="searchType" class="form-control">
					<!--  eq(==)  / ne(!=)  / <(lt) / >(gt) / <=(le) / >=(ge)
					/ empty : null(true), not null(false) / not empty : not null -->
					<!-- 삼항연산자 : 'NAME'? 'selected': '' -> name이면, 선택 -->
					<!-- c out : 특수문자 탈락, 보안성xss -->
					<option value="title" <c:out value="${SEARCH.searchType eq 'title'.toString()?'selected':'' }"/>> 제목</option>
					<option value="writer" <c:out value="${SEARCH.searchType eq 'writer'.toString()?'selected':'' }"/>> 작성자</option>
					<option value="content" <c:out value="${SEARCH.searchType eq 'conten'.toString()?'selected':'' }"/>>내용</option>
					<option value="TCW" <c:out value="${SEARCH.searchType eq 'TCW'.toString()?'selected':'' }"/>> 제목 + 작성자 + 내용</option>
				</select>
			</div>
		</div>
		
		<div class="col-sm-4">
			<div class="form-group">
				<div class="input-group">
					<input type="text" class="form-control small" name="keyword" placeholder="검색어"/>
					<div class="input-group-append">
						<!-- <input type="submit"  value="검색하기" data-role="button"/> -->
						<button type="submit" class="btn btn-primary btn-sm"> <i class="fas fa-search fa-sm" ></i> 검색</button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="col-sm-3"></div>
		
	</div>
</form>

 --%>




