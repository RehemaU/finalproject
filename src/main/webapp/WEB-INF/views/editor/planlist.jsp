<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>게시글 미리보기</title>
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet"/>
</head>
<body class="bg-light">
  <div class="container py-5">

    <!-- 검색 & 정렬 폼 -->
    <form id="searchSortForm"
          method="get"
          action="${pageContext.request.contextPath}/editor/planlist"
          class="row g-2 mb-4">
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
        <button type="submit" class="btn btn-primary btn-sm">검색</button>
      </div>
    </form>

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
                    <!-- curPage, listType, searchType, searchValue 유지하려면 여기도 히든 추가 가능 -->
                    <button type="submit"
                            class="card-title btn btn-link p-0"
                            style="font-size:1.25rem; font-weight:600;">
                      ${post.planTitle}
                    </button>
                  </form>

                  <p class="card-text">
					${post.planContent}
                  </p>
                  <p class="card-text text-end">
                    <small class="text-muted">
                      작성자: ${post.userId}
                      | 날짜: ${post.planRegdate}
                      | 추천: ${post.planRecommend}
                      | 조회: ${post.planCount}
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
