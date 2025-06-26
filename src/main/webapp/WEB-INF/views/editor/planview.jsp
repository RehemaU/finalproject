<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>게시글 상세보기</title>
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet"/>
</head>
<body class="bg-light">
  <div class="container py-5">

    <div class="card shadow-sm">
      <div class="card-body">
        <!-- 제목 -->
        <h1 class="card-title mb-3">${editor.planTitle}</h1>

        <!-- 메타 정보 -->
        <p class="text-muted mb-4">
          작성자: ${editor.userId}
          | 날짜: ${editor.planRegdate}
          | 추천: ${editor.planRecommend}
          | 조회: ${editor.planCount}
        </p>

        <hr/>

        <!-- 본문 -->
        <div class="card-text" style="white-space: pre-wrap;">
          ${editor.planContent}
        </div>

        <!-- 버튼 그룹 -->
        <div class="mt-4">
          <a href="${pageContext.request.contextPath}/editor/planlist" class="btn btn-secondary btn-sm">목록으로</a>
          <!-- 필요하면 수정/삭제 링크 추가 -->
          <a href="${pageContext.request.contextPath}/editor/planedit?planId=${editor.planId}" class="btn btn-primary btn-sm">수정</a>
          <a href="${pageContext.request.contextPath}/editor/plandelete?planId=${editor.planId}"
             class="btn btn-danger btn-sm"
             onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
        </div>
      </div>
    </div>

  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
