<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet"/>
    <link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
/* 플로팅 “후기 작성” 버튼 */
#floatingWriteBtn{
  position: fixed;          /* 스크롤해도 고정 */
  bottom: 24px;
  left: 24px;

  width: 60px;
  height: 60px;
  border-radius: 50%;

  background: #000;
  color: #fff;

  font-size: 24px;
  border: none;
  cursor: pointer;

  display: flex;
  justify-content: center;
  align-items: center;

  transition: transform .2s, box-shadow .2s;
  z-index: 999;             /* 다른 요소 위로 */
}

#floatingWriteBtn:hover{
  transform: translateY(-4px);
  box-shadow: 0 6px 16px rgba(0, 0, 0, .35);
}

#floatingWriteBtn:active{
  transform: scale(.92);
}
</style>

<style>
/* Bootstrap .btn-link 기본값을 덮어씀 */
.card-title.btn-link{
  text-decoration: none !important;  /* 밑줄 제거 */
  font-weight: 600 !important;       /* 굵기 유지 */
  color: inherit;                    /* 링크색 대신 기본 글자색 */
  font-size: 1.3rem !important;      /* ← 글씨 크기 키우기 */
}
  }
</style>

<%@ include file="/WEB-INF/views/include/head.jsp" %>   <%-- 공통 head --%>

</head>

<body class="bg-light">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %> <%-- 공통 Header/Nav --%>
  <div class="container py-5">
  
<!-- ✨ 떠다니는 “후기 작성” 버튼 -->
<button id="floatingWriteBtn"
        onclick="location.href='/editor/planeditor'"
        aria-label="후기 작성">
  <i class="fas fa-pen" style="font-size:18px;"></i> <!-- ← fa-sm 으로 조금 작게 -->
</button>

<div class="text-end mb-4">        <%-- ① 오른쪽 정렬 래퍼 --%>
    <!-- 검색 & 정렬 폼 -->
    <form id="searchSortForm"
          method="get"
          action="${pageContext.request.contextPath}/editor/planlist"
          class="d-inline-flex align-items-start gap-2">
          
      <!-- 현재 페이지 번호 유지용 히든 필드 -->
      <input type="hidden" name="curPage" value="${curPage}" />

      <!-- 정렬(select) -->
      <div class="col-auto">
        <select name="listType"
                class="form-select form-select-sm"
                onchange="this.form.submit()">
          <option value="1" <c:if test="${listType == '1'}">selected</c:if>>
            최신순
          </option>
          <option value="2" <c:if test="${listType == '2'}">selected</c:if>>
            추천순
          </option>
          <option value="3" <c:if test="${listType == '3'}">selected</c:if>>
            조회수순
          </option>
        </select>
      </div>

      <!-- 검색 조건(select) -->
      <div class="col-auto">
        <select name="searchType"
        class="form-select form-select-sm"
        onchange="if(this.value=='') document.getElementsByName('searchValue')[0].value='';">
          <option value="">전체</option>
          <option value="1" <c:if test="${searchType == '1'}">selected</c:if>>
            작성자
          </option>
          <option value="2" <c:if test="${searchType == '2'}">selected</c:if>>
            제목
          </option>
          <option value="3" <c:if test="${searchType == '3'}">selected</c:if>>
            내용
          </option>
        </select>
      </div>

	<%-- searchType이 빈 문자열이면, page 스코프의 searchValue를 빈 문자열로 덮어쓰기 --%>
	<c:if test="${empty searchType}">
	  <c:set var="searchValue" value="" scope="page"/>
	</c:if>
	
	<!-- 검색어 입력 -->
	<div class="col-auto">
	  <input type="text"
	         name="searchValue"
	         value="${searchValue}"
	         class="form-control form-control-sm"
	         placeholder="검색어 입력"/>
	</div>

      <!-- 검색 버튼 -->
      <div class="col-auto">
        <button type="submit" class="btn btn-dark btn-sm">검색</button>
      </div>
    </form>
</div>
    <!-- 전체 글 개수 -->
    <div class="mb-3">
      <strong>전체 게시글 개수:</strong> ${totalCount}
    </div>

    <!-- 게시글 리스트 (카드 형태) -->
    <div class="row">
      <c:choose>
        <c:when test="${not empty list}">
          <c:forEach var="post" items="${list}">
            <div class="col-12 mb-3">
              <div class="card shadow-sm">
                <div class="card-body">
                  <!-- 제목 클릭 시 planId 전송하는 폼 -->
                  <form action="${pageContext.request.contextPath}/editor/planview"
                        method="get">
                    <input type="hidden" name="planId" value="${post.planId}" />
                    <input type="hidden" name="curPage" value="${post.curPage}" />
                    <input type="hidden" name="listType" value="${post.listType}" />
                    <input type="hidden" name="searchType" value="${post.searchType}" />
                    <input type="hidden" name="searchValue" value="${post.searchValue}" />
                    <!-- curPage, listType, searchType, searchValue 유지하려면 여기도 히든 추가 가능 -->
                    <button type="submit"
                            class="card-title btn btn-link p-0"
                            style="font-size:1.25rem; font-weight:600;">
                      ${post.planTitle}
                    </button>
                  </form>

                  <p class="card-text">
			   <img src="/resources/upload/${post.userId}.${post.userImgEx}"
	           style="width: 80px; height: 80px; object-fit: cover; border-radius: 5px; border: 1px solid #ccc;" />
	           ${post.thumbnail}
	           <img src="/resources/editorupload/127315d2-83e5-4ad5-b628-5cebcc9507f9.jpg" alt="업로드된 이미지" contenteditable="false" data-filename="업로드된 이미지">
                  </p>
                  <p class="card-text text-end">
                    <small class="text-muted">
                      작성자: ${post.userName}
                      | 날짜: ${post.planRegdate}
                      | 추천: ${post.planRecommend}
                      | 조회: ${post.planCount}
                      | 댓글수: ${post.comCount}
                    </small>
                  </p>
                </div>
              </div>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="col-12">
            <div class="alert alert-secondary text-center mb-0">
              등록된 게시글이 없습니다.
            </div>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

  </div>
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
