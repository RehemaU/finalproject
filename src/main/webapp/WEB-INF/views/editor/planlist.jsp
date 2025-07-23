<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>후기 리스트</title>
	<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"/>
	<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <meta name="viewport" content="width=device-width, initial-scale=1" />

  <!-- Bootstrap CSS -->
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet"
  />

  <!-- Font Awesome -->
  <link
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
    rel="stylesheet"
  />

  <style>
    /* 카드 본문 요약 텍스트 두 줄로 자르기 */
    .card-text {
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }
  </style>

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

<style>
  /* 썸네일만 고정 높이로 통일 */
  .card-img-container img {
    width: 100%;
    height: 200px;      /* ← 여기서 높이 조절 */
    object-fit: cover;  /* 비율 유지하면서 잘라내기 */
  }
</style>

<%@ include file="/WEB-INF/views/include/head.jsp" %>   <%-- 공통 head --%>

</head>

<body class="bg-light">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %> <%-- 공통 Header/Nav --%>
  <div class="container py-5">
  
<!-- ✨ 떠다니는 “후기 작성” 버튼 -->
<button id="floatingWriteBtn"
        onclick="location.href='/schedule/myList'"
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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
  <c:choose>
    <c:when test="${not empty list}">
      <c:forEach var="post" items="${list}">
        <div class="col">
          <div class="card h-100 shadow-sm">

            <!-- 썸네일 -->
		    <a href="${pageContext.request.contextPath}/editor/planview?planId=${post.planId}&tCalanderListId=${post.tCalanderListId}"
		       class="card-img-container d-block">
		      <c:choose>
		        <c:when test="${not empty post.thumbnail}">
		          <c:out value="${post.thumbnail}" escapeXml="false"/>
		        </c:when>
		        <c:otherwise>
		          <img src="${pageContext.request.contextPath}/resources/editorupload/noimg.gif"
		               alt="이미지 없음"/>
		        </c:otherwise>
		      </c:choose>
		    </a>

            <div class="card-body d-flex flex-column">
              <!-- 제목 -->
              <h5 class="card-title mb-2">
                <a href="${pageContext.request.contextPath}/editor/planview?planId=${post.planId}&tCalanderListId=${post.tCalanderListId}"
                   class="text-dark text-decoration-none">
                  ${post.planTitle}
                </a>
              </h5>

              <!-- 메타 & 유저정보 컨테이너 -->
              <div class="mt-auto">
                <!-- 작성일자 · 댓글수 -->
                <p class="card-text text-muted mb-1">
                  <small>작성일: ${post.planRegdate}</small>
                </p>
                <!-- 유저 · 추천수 · 조회수 -->
                <div class="d-flex align-items-center">
<c:choose>
  <c:when test="${empty post.userImgEx}">
    <img src="${pageContext.request.contextPath}/resources/upload/profileImages.png"
         style="width:32px; height:32px; object-fit:cover; border-radius:50%; border:1px solid #ccc;"
         alt="기본프로필"/>
  </c:when>
  <c:otherwise>
    <img src="${pageContext.request.contextPath}/resources/upload/${post.userId}.${post.userImgEx}"
         style="width:32px; height:32px; object-fit:cover; border-radius:50%; border:1px solid #ccc;"
         alt="작성자"/>
  </c:otherwise>
</c:choose>
                  <span class="ms-2">${post.userName}</span>
                  <span class="ms-auto">
                    <i class="far fa-comment"></i> ${post.comCount}&nbsp;&nbsp;
                    <i class="fas fa-heart"></i> ${post.planRecommend}
                    <i class="fas fa-eye ms-3"></i> ${post.planCount}
                  </span>
                </div>
              </div>
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
