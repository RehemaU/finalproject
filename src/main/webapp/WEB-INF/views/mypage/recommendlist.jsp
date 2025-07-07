<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>좋아요한 게시글</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
  <style>
    .card-img-container img {
      width: 100%;
      height: 200px;
      object-fit: cover;
    }
    .card-text {
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }
    .user-thumbnail {
      width: 32px;
      height: 32px;
      border-radius: 50%;
      object-fit: cover;
      border: 1px solid #ccc;
    }
  </style>
<%@ include file="/WEB-INF/views/include/head.jsp" %>   <%-- 공통 head --%>
</head>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %> <%-- 공통 Header/Nav --%>
<body class="bg-light">
  <div class="container py-5">
    <h2 class="text-center mb-4">좋아요한 게시글</h2>
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">

      <c:choose>
        <c:when test="${not empty list}">
          <c:forEach var="post" items="${list}">
            <div class="col">
              <div class="card h-100 shadow-sm">

                <!-- 썸네일 -->
                <a href="/editor/planview?planId=${post.planId}" class="card-img-container d-block">
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

                <!-- 카드 본문 -->
                <div class="card-body d-flex flex-column">
                  <h5 class="card-title mb-2">
                    <a href="/editor/planview?planId=${post.planId}"
                       class="text-dark text-decoration-none">
                      ${post.planTitle}
                    </a>
                  </h5>

                  <p class="card-text text-muted small mb-2">
                    작성일: ${post.planRegdate}
                  </p>

                  <div class="d-flex align-items-center mt-auto">
                    <img src="${pageContext.request.contextPath}/resources/upload/${post.userId}.${post.userImgEx}"
                         class="user-thumbnail"
                         alt="작성자 썸네일"/>
                    <span class="ms-2">${post.userName}</span>
                    <span class="ms-auto text-muted small">
                      <i class="far fa-comment"></i> ${post.comCount}&nbsp;&nbsp;
                      <i class="fas fa-heart"></i> ${post.planRecommend}
                      <i class="fas fa-eye ms-2"></i> ${post.planCount}
                    </span>
                  </div>
                </div>

              </div>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="col-12">
            <div class="alert alert-secondary text-center mb-0">
              좋아요한 게시글이 없습니다.
            </div>
          </div>
        </c:otherwise>
      </c:choose>

    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
